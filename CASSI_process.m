function [result,time] = CASSI_process(shots, kind, tau,Ori,M,N,L,adapt,dB)
load([kind, '_L=', num2str(L), '_K=', num2str(shots)]);
    if(dB == 1 | dB == 2 | dB == 3)
        
    elseif(dB == 4 | dB == 5)
        gdmd = gdmd(1:128,1:128,1:11,:);
    end
hyperimg = Ori;
H_dmd=1;
H=L;
H1 = H/H_dmd;
shift = H_dmd;
Img=[];
Tra=0.5;

for uu=1:shots
    for vv=1:L
        dmd =zeros(N,M+L-1);
        dmd(:,1+(vv-1):M+(vv-1)) =gdmd(:,:,vv,uu);
        CC{uu,vv} = dmd;
    end
end

for j=1:shots
    graydmd{j} = gdmd(:,:,1,j)/max(gdmd(:));
end

%% Sensing process
y2=[];
y3=[];
satmax = (2^16)-1;
for j=1:shots
    imagesc(gdmd(:,:,1,j))
    y=multishot(N,H_dmd,H,H1,gdmd(:,:,:,j),hyperimg,shift);
    imagesc(y>=satmax)
    y = y(:);   % Measurement in vector form
    id = y > satmax;
    cont = sum(y > satmax)
    cont/numel(y)
    y(id) = satmax;
    ymed = medfilt2(reshape(y,[M N+L-1]));
    [Ad{j},ImG{j},Ind{j},Val{j}] = Atranspose(M,N,L,CC(j,:),length(y),id,adapt); % H matrix
    if(j+1 <= shots && adapt == 1)
        for k=j+1:shots
            [graydmd{k},ynew]=adaptive2(y,M,N,L,graydmd{k},satmax);
        end
        for i=1:L
            gdmd(:,:,i,j+1) = graydmd{j+1};
        end
        for uu=j+1:shots
            for vv=1:L
                dmd =zeros(N,M+L-1);
                dmd(:,1+(vv-1):M+(vv-1)) =gdmd(:,:,vv,uu);
                CC{uu,vv} = dmd;
            end
        end
        ynew = ynew(:);
        y(id) = ynew(id);
    end
    y2 = [y2; y];   % Measurement vertical concatenation for multishot
end
cc = hot;
for i=1:2:shots
    pause(0.1)
    colormap(cc);
    imagesc(graydmd{1}.^0.5);
end
%-------------Experiment with noise ----------------------------------
C=y2;
y0=C;
snr=10;
snraux=10^(snr/10); % Noise addition
sigma=mean(C(:))/snraux;
noise=randn(size(C))*sigma;
C=C+noise;
C=(C).*(C>0);
if abs(10*log10(mean(y0)/std(noise))-snr)<0.1
    disp('(snr_known-snr_real)<0.1db')
else
    disp('(snr_known-snr_real)>0.1db')
end
y2=C;
%% Properties Object
G = MakeONFilter('Symmlet',8);  % Wavelet transformation basis
tic;                            % Timer start
media = 0;
B = myHyperspectral_shiftKronmulti(G,M,N,L,CC,ImG(~cellfun('isempty',ImG)),Ind(~cellfun('isempty',Ind)),Val(~cellfun('isempty',Val)),media,shots); % Object
Bt = B';

%% Reconstruction process (GPSR)
wt=ones(M,N,L)*1;
wt=wt(:);
lambda_max = norm(2*((Bt)*y2),inf);
lambda=tau*lambda_max*wt;
maxiter=100;
[~,result,~,~,~,~,~]= GPSR_BB(y2,B,lambda(1),'AT',Bt,'ToleranceA',1e-12,'MaxiterA',maxiter,'Verbose',1);

%% Inverse transformation
result=reshape(result,M,N,L);               % Hyperspectral reconstructed datacube reshape
result=KronerDCTinverse(result,G,M,N,L);    % Inverse transformation
factor = 1;
result = imresize(result,factor,'bilinear');
time=toc;                                   % Timer stop

