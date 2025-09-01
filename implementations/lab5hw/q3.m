% Add Gaussian noise
noisy = imnoise(img, 'gaussian', 0, 0.01);

% Filter with median
denoised = medfilt2(noisy, [3 3]);

% Display
figure;
subplot(1,3,1); imshow(img); title('Original');
subplot(1,3,2); imshow(noisy); title('Noisy');
subplot(1,3,3); imshow(denoised); title('Denoised');

% PSNR function
function val = psnr(ref, target)
    mse = mean((ref(:) - target(:)).^2);
    if mse == 0
        val = Inf;
    else
        val = 10 * log10(1^2 / mse); % assuming images in [0,1]
    end
end

psnr_noisy = psnr(img, noisy)
psnr_denoised = psnr(img, denoised)
