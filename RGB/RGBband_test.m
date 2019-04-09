function RGBband_test(database)
%clc, clear;
%close all;
load illum_4000.mat;
load illum_6500.mat;
load('illum_25000.mat')
load xyzbar.mat;
load(database); % Data
hyperimg = double(hyperimg);

[N1,N2,L]=size(hyperimg);
reflectances=hyperimg;
l=round(linspace(1,L,L));

for j=1:L
    radiances_6500 = zeros(N1,N2);
    CC = reflectances(:,:,j);
    reflectances(:,:,j) = reflectances(:,:,j)/max(CC(:));
    radiances_6500(:,:) = reflectances(:,:,j)*illum_4000(l(j));
    [r, c, w] = size(radiances_6500);
    radiances_6500 = reshape(radiances_6500, r*c, w);
    
    XYZ = (xyzbar(l(j),:)'*radiances_6500')';
    XYZ = reshape(XYZ, r, c, 3);
    XYZ = max(XYZ, 0);
    XYZ = XYZ/max(XYZ(:));
    
    RGB = XYZ2sRGB_exgamma(XYZ);
    RGB = max(RGB, 0);
    RGB =RGB ./max(RGB(:));
    RGB = min(RGB, 1);
    gamma=0.25;
    figure(j); imshow((RGB).^gamma, 'Border','tight');
    imwrite(RGB.^gamma, ['Feathers','_band=', num2str(j),'.png']);
end
end