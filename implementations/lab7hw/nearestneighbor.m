## ========================================================
## PCA + Nearest Neighbor Classification
## ========================================================
## Author: Nahom
## Description:
##   Classifies test images by projecting them into
##   PCA space and using nearest neighbor matching.
## ========================================================

pkg load image;

% --- Parameters ---
img_dir  = '/Users/nahomsenay/Downloads/faces/';
img_size = [64, 64];
k  =  min(20, size(eigenfaces, 2));   % Number of eigenfaces to use

% --- Load dataset ---
img_files = dir(fullfile(img_dir, '*.png'));
num_imgs  = length(img_files);
if num_imgs < 2, error("Need at least 2 images."); endif

data = zeros(prod(img_size), num_imgs);
for i = 1:num_imgs
    img = im2double(imread(fullfile(img_dir, img_files(i).name)));
    if size(img,3) == 3, img = rgb2gray(img); endif
    img = imresize(img, img_size);
    data(:,i) = img(:);
endfor

% --- PCA ---
mean_face     = mean(data, 2);
centered_data = data - mean_face;
C = centered_data' * centered_data;
[Vec, Val] = eig(C);
eigenfaces = centered_data * Vec;
for i = 1:size(eigenfaces, 2)
    n = norm(eigenfaces(:, i));
    if n > 0, eigenfaces(:, i) /= n; endif
endfor

% --- Projection ---
k = min(k, size(eigenfaces, 2));
U_k = eigenfaces(:, end-k+1:end);

% Train/test split
num_train = floor(num_imgs/2);
train_data = centered_data(:, 1:num_train);
test_data  = centered_data(:, num_train+1:end);

train_proj = U_k' * train_data;
test_proj  = U_k' * test_data;

% --- Classification ---
correct = 0;
for i = 1:size(test_proj, 2)
    dists = sum((train_proj - test_proj(:, i)).^2, 1);
    [~, idx] = min(dists);
    % Dummy labels: each image unique
    true_label = num_train + i;
    pred_label = idx;
    if true_label == pred_label, correct += 1; endif
endfor

accuracy = correct / size(test_proj, 2) * 100;
fprintf('Classification Accuracy: %.2f%%\n', accuracy);
