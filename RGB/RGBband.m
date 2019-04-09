 clc, clear;
 %load('Res_HighRealData_adaptive_Oso_Nelson_CC2_K=6_L=11_tau=00007.mat')
database = 'feathers.mat';
%database = 'elmo.mat';
RGBband_test(database)
 %imshow(mat2gray(temp(:,:,[11 7 5])))
  %imshow(mat2gray(result(:,:,[11 7 5])))
 %imwrite(temp(:,:,[11 7 5]), ['RGBadaptive_K=2','.png']);

