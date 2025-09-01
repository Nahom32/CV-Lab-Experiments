img = im2double(imread('../../images/cameraman.tif'));

figure;
for i = 1:2
    if i == 1
        ksize = 5;
    else
        ksize = 7;
    end
    kernel = ones(ksize, ksize) / (ksize^2);
    filtered = imfilter(img, kernel, 'replicate');
    
    subplot(1,2,i);
    imshow(filtered);
    title([num2str(ksize) 'x' num2str(ksize) ' Averaging Filter']);
end

%% ===============================
%% For Gaussian Filter
h5 = fspecial('gaussian', [5 5], 1);
h7 = fspecial('gaussian', [7 7], 1);

gauss5 = imfilter(img, h5, 'replicate');
gauss7 = imfilter(img, h7, 'replicate');

figure;
subplot(1,2,1); imshow(gauss5); title('Gaussian 5x5');
subplot(1,2,2); imshow(gauss7); title('Gaussian 7x7');



