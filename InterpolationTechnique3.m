T = delaunay(sRGB_tr(1,:),sRGB_tr(2,:),sRGB_tr(3,:));
[t,P] = tsearchn(sRGB_tr',T,sRGB_te');

valid_idx = ~isnan(t);

R_test_rec = P(valid_idx,1)'.*Ref_tr(:, T(t(valid_idx), 1)) + ...
    P(valid_idx,2)'.*Ref_tr(:, T(t(valid_idx), 2)) + ...
    P(valid_idx,3)'.*Ref_tr(:, T(t(valid_idx), 3)) + ...
    P(valid_idx,4)'.*Ref_tr(:, T(t(valid_idx), 4));

rmse = mean(sqrt(mean((Ref_te - R_test_rec).^2, 1)))

lightSource;
E=D65(:,1:2:61);

XYZte=(100/(E*COL(:,2)))*COL'*(diag(E))*Ref_te;
XYZn=[94.81,100.000,107.30];
CIELabte=XYZ2Lab(XYZte,XYZn);

XYZrec=(100/(E*COL(:,2)))*COL'*(diag(E))*R_test_rec;
CIELabrec=XYZ2Lab(XYZrec,XYZn);

De00=mean(deltaE00(CIELabte, CIELabrec))

sRGBrec = xyztosrgb(XYZrec);
Ref_te = xyztosrgb(XYZte);

% Define the number of samples, rows, columns, and patch size
numSamples = 30;
numRows = 10;
numCols = 3;
patchSize = 200;

% Initialize images to hold the color patches for sRGBrec and Ref_te
image1 = zeros(numRows * patchSize, numCols * patchSize, 3);
image2 = zeros(numRows * patchSize, numCols * patchSize, 3);

% Loop through each sample to create the patches
for i = 1:numSamples
    % Determine the row and column index for the current sample
    row = ceil(i / numCols);
    col = mod(i - 1, numCols) + 1;
    
    % Extract the RGB values for the current sample from each variable
    rgb1 = sRGBrec(:, i);
    rgb2 = Ref_te(:, i);
    
    % Define the range for row and column indices for each patch
    rowRange = (row - 1) * patchSize + 1 : row * patchSize;
    colRange = (col - 1) * patchSize + 1 : col * patchSize;
    
    % Fill in the patches in each image by repeating the RGB values
    image1(rowRange, colRange, 1) = rgb1(1); % Red channel for sRGBrec
    image1(rowRange, colRange, 2) = rgb1(2); % Green channel for sRGBrec
    image1(rowRange, colRange, 3) = rgb1(3); % Blue channel for sRGBrec
    
    image2(rowRange, colRange, 1) = rgb2(1); % Red channel for Ref_te
    image2(rowRange, colRange, 2) = rgb2(2); % Green channel for Ref_te
    image2(rowRange, colRange, 3) = rgb2(3); % Blue channel for Ref_te
end

% Concatenate the two images horizontally for side-by-side comparison
combinedImage = [image1, image2];

% Display the combined image
figure;
imshow(combinedImage);
title('Comparison of sRGB redition of the estimated (left) and original (right) spectral reflectance');
