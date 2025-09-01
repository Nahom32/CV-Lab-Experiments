#disp("Hello World");
%disp("Hello World");
% ============================
% Load Required Package and Dataset
% ============================

img_dir = '/Users/nahomsenay/Downloads/faces/';   % Folder with images
img_files = dir(fullfile(img_dir, '*.png'));
%img_files = dir("faces");

%disp(img_files)

% Preallocate matrix
img_size = [64, 64];   % Image resolution (adjust as needed)
num_imgs = length(img_files);
disp(num_imgs)
data = zeros(prod(img_size), num_imgs);

% Load and flatten images
%for i = 1:num_imgs
%    img = im2double(imread(fullfile(img_dir, img_files(i).name)));
%    disp(img_files(i).name);
%    img = imresize(img, img_size);
%   data(:, i) = img(:);   % Flatten and store as column
%end

% Preallocate (choose grayscale or RGB)
use_rgb = false;   % set true if you want to keep color

if use_rgb
    num_pixels = prod(img_size) * 3;
else
    num_pixels = prod(img_size);
end
data = zeros(num_pixels, num_imgs);

for i = 1:num_imgs
    img = im2double(imread(fullfile(img_dir, img_files(i).name)));
    disp(img_files(i).name);

    img = imresize(img, img_size);

    % Handle grayscale vs RGB
    if use_rgb
        if size(img,3) == 1   % grayscale → convert to RGB
            img = repmat(img, [1 1 3]);
        end
    else
        if size(img,3) == 3   % RGB → convert to grayscale
            img = rgb2gray(img);
        end
    end

    % Flatten and store as column
    data(:, i) = img(:);
end


% ============================
% Mean Face and Data Centering
% ============================
mean_face = mean(data, 2);
centered_data = data - mean_face;

% Visualize Mean Face
imshow(reshape(mean_face, img_size), []);
title('Mean Face');


% ============================
% PCA for Eigenfaces
% ============================
% Covariance Matrix (smaller trick)
C = centered_data' * centered_data;
[Vec, Val] = eig(C);

% Project back to image space
eigenfaces = centered_data * Vec;

% Normalize eigenfaces
for i = 1:size(eigenfaces, 2)
    eigenfaces(:, i) = eigenfaces(:, i) / norm(eigenfaces(:, i));
end


% ============================
% Display Top 5 Eigenfaces
% ============================
figure;
num_to_show = min(5, size(eigenfaces, 2));

for i = 1:num_to_show
    subplot(1,num_to_show,i);
    imshow(reshape(eigenfaces(:, end-i+1), img_size), []);
    title(['Eigenface ', num2str(i)]);
end



% ============================
% Image Reconstruction using Top k Eigenfaces
% ============================
k = min(20, size(eigenfaces, 2));
U_k = eigenfaces(:, end-k+1:end);

% Project the first image
proj = U_k' * centered_data(:, 1);

% Reconstruct
reconstructed = U_k * proj + mean_face;

imshow(reshape(reconstructed, img_size), []);
title(['Reconstructed Image with ', num2str(k), ' Eigenfaces']);

