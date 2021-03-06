image1 = imread('images/noisy1.jpg');
filteredImage1 = noiseRemoval(image1, 11.3, 1, 0);

image2 = imread('images/noisy2.jpg');
filteredImage2 = noiseRemoval(image2, 8.5, 2, 0);

image3 = imread('images/noisy3.jpg');
filteredImage3 = noiseRemoval(image3, 10.9, 3, 0);

figure
subplot(3, 2, 1), imshow(image1);
subplot(3, 2, 2), imshow(filteredImage1, []);
subplot(3, 2, 3), imshow(image2);
subplot(3, 2, 4), imshow(filteredImage2, []);
subplot(3, 2, 5), imshow(image3);
subplot(3, 2, 6), imshow(filteredImage3, []);

function spectrum = spectrumFourier(F)
    spectrum = abs(F);
    spectrum = log(spectrum+1);
end

function imageResult = noiseRemoval(image, threshold, center, verbose)
    image = rgb2gray(image);
    F = fft2(double(image));
    F1 = fftshift(F);
    
    F2 = spectrumFourier(F1);
    if verbose == 1
        figure, imagesc(F2); colormap(gray); 
        title('magnitude spectrum');
    end
    
    brightSpikes = F2 > threshold;
    if verbose == 1
        figure, imagesc(brightSpikes); colormap(gray); 
        title('bright spikes');
    end
    
    if center == 1
        brightSpikes(145:160, :) = 0;
    elseif center == 2
        brightSpikes(190:360, :) = 0;
        brightSpikes(:, 160:400) = 0;
    elseif center == 3
        brightSpikes(250:300, :) = 0;
    end
    
    F1(brightSpikes) = 0;
    if verbose == 1
        figure, imagesc(spectrumFourier(F1)); colormap(gray); 
        title('filtered magnitude spectrum');
    end
    
    imageResult = uint8(real(ifft2(ifftshift(F1))));
end