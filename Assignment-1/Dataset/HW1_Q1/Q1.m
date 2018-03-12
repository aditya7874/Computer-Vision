H_Image=rgb2gray(imread('E:\Sem 6\Computer Vision\HW1_Q1\Afghan_girl_after.jpg'));
L_Image=rgb2gray(imread('E:\Sem 6\Computer Vision\HW1_Q1\Afghan_girl_before.jpg'));

% ------ frequency domain ------------%

alpha=200;
beta=25;
H_Image=fft2(double(H_Image),size(H_Image,1),size(H_Image,2));
L_Image=fft2(double(L_Image),size(L_Image,1),size(L_Image,2));
H_Image=fftshift(H_Image);
L_Image=fftshift(L_Image);
figure,
imshow(H_Image);
figure,
imshow(L_Image);    

Lfilter=zeros(size(L_Image,1),size(L_Image,2));

for i = 1:size(L_Image,1)
    for j = 1:size(L_Image,2)
        dist= sqrt((i-size(L_Image,1)/2)^2 + (j-size(L_Image,2)/2)^2);
        Lfilter(i,j) = exp(-(dist)^2/(2*(beta)^2));
    end
end
Hfilter=zeros(size(H_Image,1),size(H_Image,2));

for i = 1:size(H_Image,1)
    for j = 1:size(H_Image,2)
        dist= sqrt((i-size(H_Image,1)/2)^2 + (j-size(H_Image,2)/2)^2);
        Hfilter(i,j) = 1-exp(-(dist)^2/(2*(alpha)^2));
    end
end

figure,
imshow(Hfilter);
figure,
imshow(Lfilter);

H_Image=H_Image.*(Hfilter);
L_Image=L_Image.*fftshift(Lfilter);
%Hybrid=H_Image+L_Image;
%Hybrid=real(ifft2(Hybrid));
H_Image=ifft2((H_Image));
L_Image=ifft2((L_Image));

figure,
imshow(abs(H_Image));
figure,
imshow(abs(L_Image));

% ----- Spatial domain ----- %
%{
alpha=50;
H_Image=fft2(double(H_Image),size(H_Image,1),size(H_Image,2));
L_Image=fft2(double(L_Image),size(L_Image,1),size(L_Image,2));
H_Image=fftshift(H_Image);
L_Image=fftshift(L_Image);
 Hfilter=zeros(size(H_Image,1),size(H_Image,2));

    for i = 1:size(H_Image,1)
            for j = 1:size(H_Image,2)
		    dist= sqrt((i-size(H_Image,1)/2)^2 + (j-size(H_Image,2)/2)^2);
		    Hfilter(i,j) = 1-exp(-(dist)^2/(2*(alpha)^2));
            end
    end
 Lfilter=fspecial('Gaussian',18,3);
 Lfilter=fft2(double(Lfilter),size(L_Image,1),size(L_Image,2));
 L_Image=L_Image.*Lfilter;
 L_Image=ifft2(L_Image);
 H_Image=H_Image.*(Hfilter);
 H_Image=ifft2((H_Image));
 figure,
 imshow(abs(L_Image));
 figure,
    imshow(abs(H_Image));
   Hybrid=abs(L_Image)+abs(H_Image);
   figure,
   imshow(Hybrid);

%}