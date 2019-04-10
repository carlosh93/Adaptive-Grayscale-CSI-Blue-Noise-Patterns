function [Sat] = CASSI_process_mesu2(shots, kind, tau,Ori,M,N,L,adapt)
load([kind, '_L=', num2str(L), '_K=', num2str(shots)]);

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

j = 1;
y=multishot(N,H_dmd,H,H1,gdmd(:,:,:,j),hyperimg,shift);

y = y(:);   % Measurement in vector form

id = y > satmax;
cont = sum(y > satmax)
Sat = cont/numel(y)
y(id) = satmax;
ymed = medfilt2(reshape(y,[M N+L-1]));

end