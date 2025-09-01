img = imread('../images/cameraman.tif');
img = im2double(img);

figure;  % Open a new figure window

## ===============================
## 1. Original Image
## ===============================
subplot(3,3,1); % 3x3 grid, position 1
imshow(img);
title('Original Image');

## ===============================
## 2. Averaging (Box) Filter
## ===============================
kernel = ones(3,3)/9;
avg_filtered = imfilter(img, kernel);

subplot(3,3,2);
imshow(avg_filtered);
title('Averaging Filter (3x3)');

## ===============================
## 3. Gaussian Filtering
## ===============================
h = fspecial('gaussian', [5 5], 1);   % 5x5 Gaussian kernel, sigma = 1
gauss_filtered = imfilter(img, h, 'replicate');

subplot(3,3,3);
imshow(gauss_filtered);
title('Gaussian Filter (\sigma = 1)');

## ===============================
## 4. Median Filtering
## ===============================
[h_img, w_img, ~] = size(img);
img_resize = imresize(img, [h_img,h_img]);
median_filtered = medfilt2(img_resize);

subplot(3,3,4);
imshow(median_filtered);
title('Median Filter');

## ===============================
## 5. Sharpening with Laplacian
## ===============================
laplacian_kernel = [0 -1 0; -1 4 -1; 0 -1 0];
laplacian_img = imfilter(img, laplacian_kernel);
sharpened_img = img + laplacian_img;

subplot(3,3,5);
imshow(sharpened_img);
title('Sharpened (Laplacian)');

## ===============================
## 6. Image Correlation
## ===============================
corr_output = conv2(img, kernel, 'same');

subplot(3,3,6);
imshow(corr_output, []);
title('Correlation Output');

## ===============================
## 7. Edge Detection (Sobel)
## ===============================
sobel_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_y = [-1 -2 -1; 0 0 0; 1 2 1];
gx = imfilter(img, sobel_x);
gy = imfilter(img, sobel_y);
gradient_magnitude = sqrt(gx.^2 + gy.^2);

subplot(3,3,7);
imshow(gradient_magnitude, []);
title('Sobel Edge Detection');
