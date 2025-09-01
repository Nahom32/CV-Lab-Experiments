img = im2double(imread('../../images/cameraman.tif'));
% Gaussian blur
h = fspecial('gaussian', [5 5], 1);
blurred = imfilter(img, h, 'replicate');

% Mask
mask = img - blurred;

% Unsharp masking (adjust k for strength)
k = 1.5;
sharpened = img + k * mask;

figure;
subplot(1,3,1); imshow(img); title('Original');
subplot(1,3,2); imshow(blurred); title('Blurred');
subplot(1,3,3); imshow(sharpened); title('Unsharp Masked');
