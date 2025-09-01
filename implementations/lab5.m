img = imread('../images/cameraman.tif');
img = im2double(img);
imshow(img);
title('Original Image');

%Averaging
kernel = ones(3,3)/9;
avg_filtered = imfilter(img, kernel);
imshow(avg_filtered);
title(' Averaging Filter (3x3)');


%Gaussian Filtering
gauss_filtered = imgaussfilt(img, 1);
imshow(gauss_filtered);
title('Gaussian Filter (Sigma = 1)');

## ===============================
## 2. Preparing the Environment
## ===============================

%img = imread('../images/cameraman.tif');
img = im2double(img);
imshow(img);
title('Original Image');


## ===============================
## 3. Averaging (Box) Filter
## ===============================
kernel = ones(3,3)/9;
avg_filtered = imfilter(img, kernel);
imshow(avg_filtered);
title('Averaging Filter (3x3)');


## ===============================
## 4. Gaussian Filtering
## ===============================
#gauss_filtered = imgaussfilt(img, 1);
h = fspecial('gaussian', [5 5], 1);   % 5x5 Gaussian kernel, sigma = 1
gauss_filtered = imfilter(img, h, 'replicate');
imshow(gauss_filtered);
title('Gaussian Filter (Sigma = 1)');



## ===============================
## 5. Median Filtering
## ===============================
[h, w, ~] = size(img);
img_resize = imresize(img, [h,h])

median_filtered = medfilt2(img_resize);
imshow(median_filtered);
title('Median Filtered Image');


## ===============================
## 6. Sharpening with Laplacian Filter
## ===============================
laplacian_kernel = [0 -1 0; -1 4 -1; 0 -1 0];
laplacian_img = imfilter(img, laplacian_kernel);
sharpened_img = img + laplacian_img;
imshow(sharpened_img);
title('Sharpened Image (Laplacian)');


## ===============================
## 7. Image Correlation
## ===============================
corr_output = conv2(img, kernel, 'same');
imshow(corr_output, []);
title('Correlation Output');


## ===============================
## 8. Custom Filter Example: Edge Detection (Sobel)
## ===============================
sobel_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_y = [-1 -2 -1; 0 0 0; 1 2 1];
gx = imfilter(img, sobel_x);
gy = imfilter(img, sobel_y);
gradient_magnitude = sqrt(gx.^2 + gy.^2);
imshow(gradient_magnitude, []);
title('Edge Detection using Sobel');

