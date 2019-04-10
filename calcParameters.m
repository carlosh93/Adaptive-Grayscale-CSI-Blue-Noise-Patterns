function [] = calcParameters(dB,kind0,database)
%calcParameters - Function to obtain the saturation parameters using in the
%colored coded aperture generation.
%
% Syntax:  [] = calcParameters(dB,kind0,database)
%
% Inputs:
%    dB - Database number
%    kind0 - Type of coded aperture to be generated
%    database - Database name
%
% Other m-files required: CASSI_process_mesu2.m
% MAT-files required: none
%
% See also: Run_complete.m,  exeOpt.m
% Author: Carlos Hinojosa, Nelson Diaz and Henry Arguello
% Universidad Industrial de Santander
% High Dimensional Signal Processing Group (HDSP)
% Research Group Website: http://hdspgroup.com
% Corresponding Author Email: nelson.diaz@saber.uis.edu.co
% Author Website: http://carlosh93.github.io
% April 9 2019; Last revision: 8-Apr-2019
%------------- BEGIN CODE --------------

adaptive = 1;

for shots = [2 3 4 5 6 7 8]
    if(length(database{1})==length('superballs_ms') && unique(database{1} == 'superballs_ms'))
        if(kind0 == 0)
            kind = {'random_M=256_N=256'};   % random_superballs_ms
            C =[0.91, 2.26, 3.85, 4.72, 5.53, 6.45, 7.7, 9.7 14.5 100]; % superballs_ms random
        elseif(kind0 == 1)
            kind = {'grayscale_Tr=0125_M=256_N=256'}; % grayscale
            C = [4.6, 10.8, 15.7, 22.2, 31.8, 45.5, 70.9, 135.2 90000.95 200]; %superballs_ms grayscale
        elseif(kind0 == 2)
            kind = {'grayscale_bluenoise_Tr=0125_M=256_N=256'}; % blue noise grayscale
            C = [3.738, 9.4, 13.4, 19.5, 26.7, 34.3, 45.6, 68.2 90000.95 200]; %superballs_ms blue noise
        end
    elseif(length(database{1})==length('glass_tiles_ms') && unique(database{1} == 'glass_tiles_ms'))
        if(kind0 == 0)
            kind = {'random_M=256_N=256'};   % random_superballs_ms
            C =[0.512, 0.65, 0.797, 1.026, 1.585, 3.49, 4.8, 6.42 14.5 100]; % glass_tiles_ms random
        elseif(kind0 == 1)
            kind = {'grayscale_Tr=0125_M=256_N=256'}; % grayscale
            C = [4.6, 10.8, 15.7, 22.2, 31.8, 45.5, 70.9, 135.2 90000.95 200]; %superballs_ms grayscale
        elseif(kind0 == 2)
            kind = {'grayscale_bluenoise_Tr=0125_M=256_N=256'}; % blue noise grayscale
            C = [1.86, 2.55, 3.3, 5.43, 10.15, 15.9, 25, 37.8, 90000.95 200]; %superballs_ms grayscale
        end
    elseif(length(database{1})==length('beads_ms') && unique(database{1} == 'beads_ms'))
        if(kind0 == 0)
            kind = {'random_M=256_N=256'};   % random_superballs_ms
            C =[0.4825, 0.642, 0.823, 1.051, 1.368, 1.855, 2.78, 4.727 14.5 100]; % glass_tiles_ms random
        elseif(kind0 == 1)
            kind = {'grayscale_Tr=0125_M=256_N=256'}; % grayscale
            C = [4.6, 10.8, 15.7, 22.2, 31.8, 45.5, 70.9, 135.2 90000.95 200]; %superballs_ms grayscale
        elseif(kind0 == 2)
            kind = {'grayscale_bluenoise_Tr=0125_M=256_N=256'}; % blue noise grayscale
            C = [1.73, 2.525, 3.495, 4.88, 7.18, 11, 19, 35.1, 90000.95 200]; %superballs_ms grayscale
        end
    elseif(length(database{1})==length('fullFlor') && unique(database{1} == 'fullFlor'))
        if(kind0 == 0)
            kind = {'random_M=128_N=128'};   % random_superballs_ms
            C = [2.55 3.31 4.38 5.8 7.26 8.74 10.4 12.0];
        elseif(kind0 == 1)
            kind = {'grayscale_Tr=0125_M=256_N=256'}; % grayscale
            C = [4.6, 10.8, 15.7, 22.2, 31.8, 45.5, 70.9, 135.2 90000.95 200]; %fullFlor_ms grayscale
        elseif(kind0 == 2)
            kind = {'grayscale_bluenoise_M=128_N=128'}; % blue noise grayscale
        end
    end
    
    load(database{1});
    
    for v=1:8
        Sat = 1000;
        while (abs(Sat - (v/10))) > 0.001
            if(dB == 1 || dB == 2 || dB == 3)
                Ori = imresize(double(hyperimg),0.5);
                ind = round(linspace(1,31,16));
            elseif(dB == 4 || dB == 5)
                Ori = imresize(double(hyperimg),1);
                ind = round(linspace(1,1,11));
            end
            Ori = Ori(:,:,ind)*C(v);
            [M,N,L]=size(Ori);
            m = 1;
            iv=0.01;
            fv=30;
            st=6;
            ratio=linspace(iv,fv,st);
            order=1e-5;
            tau=ratio*order;
            k = 1;
            t = 1;
            [Sat] = CASSI_process_mesu2(shots(m),kind{k},tau(t),Ori,M,N,L,adaptive);
            r = 0.001;
            if (Sat > v/10)
                C(v) = C(v) - r;
            else
                C(v) = C(v) + r;
            end
        end
    end
    save(['parameters_results/C_shot=',num2str(shots),'_',database{1}],'C');
end
end

%------------- END OF CODE --------------
% If you have any comment or question, feel free to contact the
% corresponding author (nelson.diaz@saber.uis.edu.co)
