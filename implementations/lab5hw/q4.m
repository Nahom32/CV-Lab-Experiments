% Extract a patch (say a 30x30 region)
patch = img(50:79, 50:79);

% Correlate patch with full image
corr_map = normxcorr2(patch, img);

% Show results
figure;
subplot(1,2,1); imshow(patch, []); title('Template Patch');
subplot(1,2,2); imshow(corr_map, []); title('Correlation Map');

[max_corr, idx] = max(corr_map(:));
[y, x] = ind2sub(size(corr_map), idx);
disp(["Best match at (", num2str(y), ",", num2str(x), ") with correlation = ", num2str(max_corr)]);
