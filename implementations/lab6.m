
% ============================
% Load Required Package and Image
% ============================
%pkg load image;
figure;
subplot(3,3,1)
img = im2double(imread('../images/cameraman.tif'));
imshow(img);
title('Original Image');


% ============================
% Discrete Fourier Transform (DFT)
% ============================
subplot(3,3,2)
% Apply 2D Fourier Transform
F = fft2(img);
F_shifted = fftshift(F);
F_magnitude = log(1 + abs(F_shifted));
imshow(F_magnitude, []);
title('Magnitude Spectrum of DFT');
subplot(3,3,3)
% Inverse Fourier Transform
reconstructed = real(ifft2(F));
imshow(reconstructed);
title('Reconstructed Image from DFT');


% ============================
% Discrete Cosine Transform (DCT)
% ============================
subplot(3,3,4)
% Apply 2D DCT
dct_img = dct2(img);
imshow(log(abs(dct_img)), []);
title('DCT Coefficients');
subplot(3,3,5)
% Inverse DCT
reconstructed_dct = idct2(dct_img);
imshow(reconstructed_dct);
title('Reconstructed Image from DCT');


% ============================
% Discrete Wavelet Transform (DWT)
% ============================

% Install and load wavelet package (first time only)
% pkg install -forge wavelet;
function [LL, LH, HL, HH] = my_dwt2(img)
  
  img = double(img);

 
  h = [1 1] / sqrt(2);   
  g = [1 -1] / sqrt(2);  

  % --- Step 1: Filter rows ---
  % Convolve with low-pass and high-pass filters
  L_rows = conv2(img, h, 'same');
  H_rows = conv2(img, g, 'same');

  % Downsample by 2 along columns
  L_rows = L_rows(:,1:2:end);
  H_rows = H_rows(:,1:2:end);

  % --- Step 2: Filter columns ---
  % Convolve with low-pass and high-pass filters (transpose)
  LL = conv2(L_rows, h', 'same');
  HL = conv2(L_rows, g', 'same');
  LH = conv2(H_rows, h', 'same');
  HH = conv2(H_rows, g', 'same');

  % Downsample by 2 along rows
  LL = LL(1:2:end, :);
  HL = HL(1:2:end, :);
  LH = LH(1:2:end, :);
  HH = HH(1:2:end, :);
end


% Apply 2D DWT using Haar wavelet
% [LL, LH, HL, HH] = dwt2(img, 'haar');
% subplot(2,2,1), imshow(LL, []), title('Approximation (LL)');
% subplot(2,2,2), imshow(LH, []), title('Horizontal Detail (LH)');
% subplot(2,2,3), imshow(HL, []), title('Vertical Detail (HL)');
% subplot(2,2,4), imshow(HH, []), title('Diagonal Detail (HH)');

% % Inverse DWT
% reconstructed_dwt = idwt2(LL, LH, HL, HH, 'haar');
% imshow(reconstructed_dwt);
% title('Reconstructed Image from DWT');
