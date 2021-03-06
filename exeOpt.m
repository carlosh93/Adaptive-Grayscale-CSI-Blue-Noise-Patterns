function [] = exeOpt(C,dB,kind0)
%exeOpt - Function that perform the CSI acquisition and reconstruction (see function
%CASSI_process.m) using the designed coded apertures.
%
% Syntax:  [] = exeOpt(C,dB,kind0)
%
% Inputs:
%    C - Parameters used to build the colored coded aperture
%    dB - Database number
%    kind0 - Type of coded aperture to be generated
%
% Other m-files required: CASSI_process.m, fun_PSNR.m
%
% See also: CASSI_process.m,  fun_PSNR.m, multishot.m
% Author: Carlos Hinojosa, Nelson Diaz and Henry Arguello
% Universidad Industrial de Santander
% High Dimensional Signal Processing Group (HDSP)
% Research Group Website: http://hdspgroup.com
% Corresponding Author Email: nelson.diaz@saber.uis.edu.co
% Author Website: http://carlosh93.github.io
% April 9 2019; Last revision: 10-Apr-2019
%------------- BEGIN CODE --------------

shots = [2 3 4 5 6 7 8];                  % Number of shots to be captured

adaptive = 1;


if(dB == 1)
    database = {'beads_ms'};
elseif(dB == 2)
    database = {'glass_tiles_ms'};
elseif(dB == 3)
    database = {'superballs_ms'};
elseif(dB == 4)
    database = {'fullflor'};
elseif(dB == 5)
    database = {'OSO_FULL'};
end

%% Load glass_tiles_ms
if(length(database{1})==length('superballs_ms') && unique(database{1} == 'superballs_ms'))
    load(database{1});
    if(kind0 == 0)
        kind = {'random_M=256_N=256'};   % random_superballs_ms
    elseif(kind0 == 1)
        kind = {'grayscale_Tr=0125_M=256_N=256'}; % grayscale
    elseif(kind0 == 2)
        kind = {'grayscale_bluenoise_Tr=0125_M=256_N=256'}; % blue noise grayscale
    end
    %% Load glass_tiles_ms
elseif(length(database{1})==length('glass_tiles_ms') && unique(database{1} == 'glass_tiles_ms'))
    load(database{1});
    if(kind0 == 0)
        kind = {'random_M=256_N=256'};   % random_superballs_ms
    elseif(kind0 == 1)
        kind = {'grayscale_Tr=0125_M=256_N=256'}; % grayscale
    elseif(kind0 == 2)
        kind = {'grayscale_bluenoise_Tr=0125_M=256_N=256'}; % blue noise grayscale
    end
    %% Load beads_ms
elseif(length(database{1})==length('beads_ms') && unique(database{1} == 'beads_ms'))
    load(database{1});
    if(kind0 == 0)
        kind = {'random_M=256_N=256'};   % random_superballs_ms
    elseif(kind0 == 1)
        kind = {'grayscale_Tr=0125_M=256_N=256'}; % grayscale
    elseif(kind0 == 2)
        kind = {'grayscale_bluenoise_Tr=0125_M=256_N=256'}; % blue noise grayscale
    end
    %% Load fullflor
elseif(length(database{1})==length('fullflor') && unique(database{1} == 'fullflor'))
    load(database{1});
    hyperimg = Ori;
    if(kind0 == 0)
        kind = {'random_M=128_N=128'};   % random_superballs_ms
    elseif(kind0 == 1)
        kind = {'grayscale_Tr=0125_M=256_N=256'}; % grayscale
    elseif(kind0 == 2)
        kind = {'grayscale_bluenoise_M=128_N=128'}; % blue noise grayscale
    end
end
tauT = zeros(length(shots),8);
psnrT = zeros(length(shots),8);

for v=1:8
    if(dB == 1 | dB == 2 | dB == 3)
        Ori = imresize(double(hyperimg),0.5);
        ind = round(linspace(1,31,16));
    elseif(dB == 4 | dB == 5)
        Ori = imresize(double(hyperimg),1);
        ind = round(linspace(1,1,11));
    end
    
    Ori = Ori(:,:,ind)*C(v);
    [M,N,L]=size(Ori);
    for m=1:length(shots)
        psnr2=[];
        temporal = 0;
        iv=0.01;
        fv=30;
        st=6;
        ratio=linspace(iv,fv,st);
        order=1e-5;
        tau=ratio*order;
        tauhistory=[];
        tauhistory=[tauhistory tau];
        for p=1:4
            psnr1=[];
            for k=1:length(kind)
                for t=1:length(tau)
                    psnrRep =[];
                    [result,time] = CASSI_process(shots(m),kind{k},tau(t),Ori,M,N,L,adaptive,dB);    % Execute main function  %
                    
                    for l=1:L
                        [psnr4(l)] = fun_PSNR(Ori(:,:,l),result(:,:,l));
                    end
                    if(mean(psnr4) > temporal)
                        temporal = mean(psnr4);
                        bestRes1 = result;
                    end
                    psnrRep=[mean(psnr4) psnrRep];
                    psnr = mean(psnrRep);
                    psnr1=[psnr1 psnr];
                    psnr2=[psnr2 psnr];
                end
                
                bestRes = Ori;
                
                bestRes = bestRes1;
                [ma, pos]=max(psnr1);
                if (p==1)
                    aux=linspace((ratio(pos)-6),(ratio(pos)+6),6);
                    ratio=aux;
                    tau=abs(aux)*order;
                    tauhistory=[tauhistory tau];
                    clear psnr1
                end
                if (p==2)
                    aux=linspace((ratio(pos)-2.4),(ratio(pos)+2.4),6);
                    ratio=aux;
                    tau=abs(aux)*order;
                    tauhistory=[tauhistory tau];
                    clear psnr1
                end
                
                if (p==3)
                    aux=linspace((ratio(pos)-0.96),(ratio(pos)+0.96),6);
                    tau=abs(aux)*order;
                    tauhistory=[tauhistory tau];
                end
                
                if (p==4)
                    
                    subplot(1,2,1),RGB_test(bestRes)
                    subplot(1,2,2),RGB_test(Ori)
                    disp('here');
                end
                
                [ma pos]=max(psnr2);
                psnrT(shots(m),v)=ma;
                tauT(shots(m),v) = tauhistory(pos);
                a = ['Results/',kind{1},'_database=',database{1},'_C=',num2str(v),'_K=', num2str(shots(m)), '_L=', num2str(L),'.mat'];
                save(a,'psnrT','tauT','bestRes');
            end
        end
    end
end
end

%------------- END CODE --------------