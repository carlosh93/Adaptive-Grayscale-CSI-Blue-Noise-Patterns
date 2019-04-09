function RGB_test(database)

addpath Data\
load illum_4000.mat;
load illum_6500.mat;
load('illum_25000.mat')
load xyzbar.mat;
%load(database); % Data
%hyperimg = reflectances(1:512,1:512,:); %Ori %bestRes
hyperimg = double(database);
[N1,N2,L]=size(hyperimg);
reflectances=hyperimg;
l=round(linspace(1,31,L));

radiances = zeros(size(reflectances));  % initialize array
for j=1:L
    CC = reflectances(:,:,j);
    reflectances(:,:,j) = reflectances(:,:,j)/max(CC(:));
    radiances(:,:,j) = reflectances(:,:,j)*illum_6500(l(j));
end
[r, c, w] = size(radiances);
radiances = reshape(radiances, r*c, w);

XYZ = (xyzbar(l(:),:)'*radiances')';
XYZ = reshape(XYZ, r, c, 3);
XYZ = max(XYZ, 0);
XYZ = XYZ/max(XYZ(:));

RGB = XYZ2sRGB_exgamma(XYZ);
RGB = max(RGB, 0);
RGB =RGB ./max(RGB(:));
RGB = min(RGB, 1);
gamma = 0.45;
pos   = [196 225;75 282;231 332];%;7 102;79 116]; % position bear
%pos   = [105 53]%; 9 15; 22 120];
color = {'red'};
%RGB = insertMarker(RGB,pos,'o','color',color,'size',5);
figure(1); imshow((RGB).^gamma, 'Border','tight');
imwrite(RGB.^gamma, 'RGB_Enrique_Original.png');
end