% Read image
[f, map] = imread('images/tunnel.jpg');
f = rgb2gray(f);

% show original image
imshow(f, map), title('Original image');

% kernel to get brighter image
h = [0 -1 0; -1 5 -1; 0 -1 0];

% fourier transform
[M,N] = size(f);
P = 2*M;
Q = 2*N;
F=fft2(double(f),P,Q);
H=fft2(double(h),P,Q);
% multiply with kernel
F2=H.*F;
f2=ifft2(F2);

% get original form
g=real(f2);
fsharp=g(1:M,1:N);

% show result
figure, imshow(fsharp, map), title('Brighter image');
