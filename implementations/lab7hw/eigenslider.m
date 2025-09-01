img_dir  = '/Users/nahomsenay/Downloads/faces/';
img_size = [64, 64];

% --- Load dataset ---
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

% --- Create Figure and Axes ---
fig = figure;
ax = axes('Parent', fig);
imshow(reshape(eigenfaces(:, end), img_size), []);
title(['Eigenface 1']);

% --- Slider ---
h = uicontrol('style','slider',...
              'units','normalized',...
              'position',[0.25 0.02 0.5 0.05],...
              'min',1,'max',size(eigenfaces,2),'value',1,...
              'sliderstep',[1/(size(eigenfaces,2)-1), 10/(size(eigenfaces,2)-1)],...
              'Callback', @(src,evt) update_plot(src, eigenfaces, img_size, ax));

% --- Update function ---
function update_plot(h, eigenfaces, img_size, ax)
    idx = round(get(h,'value'));
    imshow(reshape(eigenfaces(:, end-idx+1), img_size), 'Parent', ax);
    title(ax, ['Eigenface ', num2str(idx)]);
end