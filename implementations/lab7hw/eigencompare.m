


img_dir  = '/Users/nahomsenay/Downloads/faces';       
img_size = [64, 64];      

img_files = dir(fullfile(img_dir, '*.png'));
num_imgs  = length(img_files);
if num_imgs == 0, error("No images found!"); endif

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

% --- Reconstruction with different k ---
k_values = [5, 10, 50];
figure;
for j = 1:length(k_values)
    k = min(k_values(j), size(eigenfaces, 2));
    U_k = eigenfaces(:, end-k+1:end);
    proj = U_k' * centered_data(:, 1);
    reconstructed = U_k * proj + mean_face;
    subplot(1,length(k_values),j);
    imshow(reshape(reconstructed, img_size), []);
    title([num2str(k), ' Eigenfaces']);
endfor
