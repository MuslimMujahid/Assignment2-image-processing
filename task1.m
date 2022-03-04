% Read image
f = imread('images/task1 (4).jpg');

% show original image
imshow(f), title('Original image');
f = im2double(f);
[M,N,O] = size(f);

P = 2*M;
Q = 2*N;
fp = zeros(P,Q,O);

for i = 1:P
    for j = 1:Q
        if i <= M && j<= N
            fp(i,j,:) = f(i,j,:);
        else
            fp(i,j,:) = 0;
        end
    end
end
imshow(f);title('original image');
figure; imshow(fp);title('padded image');

Fc = fftshift(fft2(fp(:,:,1)));
S2=log(1+abs(Fc));
figure; imshow(S2, []);title('padded image fourier spectrum');

F = fft2(double(fp(:,:,1)));
D0 = 50;
u = 0:(P-1);
v = 0:(Q-1);

idx = find(u > P/2);
u(idx) = u(idx) - P;
idy = find(v > Q/2);
v(idy) = v(idy) - Q;
[V, U] = meshgrid(v, u);
D = sqrt(U.^2+v.^2);

H = double(D <=D0);
H = fftshift(H); figure;imshow(H);title('LPF Ideal Mask');

H = ifftshift(H);
LPF_f = H.*F;
LPF_f2=real(ifft2(LPF_f));
figure; imshow(LPF_f2);title('output image after inverse 2D DFT');

% show result
figure, imshow(LPF_f2(1:M,1:N), map), title('output image');
