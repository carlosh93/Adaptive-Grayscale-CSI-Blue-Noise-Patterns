% Run_complete.m - Run Simulations for the paper: 
% Adaptive grayscale compressive spectral imaging using optimal 
% blue noise coding patterns
% Before Run this script please Download the databases, which are freely
% available from the following websites:
% -Databases from columbia CAVE projects (www.cs.columbia.edu/CAVE/databases/multispectral)
%   * beads_ms: http://www.cs.columbia.edu/CAVE/databases/multispectral/zip/beads_ms.zip
%   * glass_tiles_ms: http://www.cs.columbia.edu/CAVE/databases/multispectral/zip/glass_tiles_ms.zip
%   * superballs_ms: http://www.cs.columbia.edu/CAVE/databases/multispectral/zip/superballs_ms.zip
% -Databases from High Dimensiona Signal Processing Group Optics Laboratory
% at Universidad Industrial de Santander, Colombia (https://github.com/hdspgroup/spectral-image-databases)
%   * Fullflor: https://github.com/hdspgroup/spectral-image-databases/raw/master/data/fullFlor.mat
%   * OSO_FULL: https://github.com/hdspgroup/spectral-image-databases/raw/master/data/OSO_FULL.mat
% 
% After downloading the databases from CAVE Projects, please move the files
% to the 'Data' folder.
% Similarly, after downloading the databases from HDSP optics laboratory,
% place the data in the 'realdata' folder
%
% Other m-files required: calcParameters.m
%
% Author: Carlos Hinojosa, Nelson Diaz and Henry Arguello
% Universidad Industrial de Santander
% High Dimensional Signal Processing Group (HDSP)
% Research Group Website: http://hdspgroup.com
% Corresponding Author Email: nelson.diaz@saber.uis.edu.co
% Author Website: http://carlosh93.github.io
% April 9 2019; Last revision: 10-Apr-2019
%
%------------- BEGIN CODE --------------

clc, clear, close all;

%% Load auxiliary files
addpath('adaptive/','Data/','realdata/','RGB/','SupportFast/');

%% Parameters
dB = 3;
kind0 = 2;

switch(dB)
    case 1
        database = {'beads_ms'};
    case 2
        database = {'glass_tiles_ms'};
    case 3
        database = {'superballs_ms'};
    case 4
        database = {'fullflor'};
    case 5
        database = {'OSO_FULL'};
end


calcParameters(dB,kind0,database);


%% Run main Subroutine
x = zeros(7,10);

for i=2:8
    data = ['parameters_results/C_shot=',num2str(i),'_',database{1},'.mat'];
    load(data);
    x(i-1,:) = C;
end
x = mean(x);
exeOpt(C,dB,kind0);

%------------- END CODE --------------