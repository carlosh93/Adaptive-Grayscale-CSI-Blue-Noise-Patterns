function [Sat] = CASSI_process_mesu2(shots, kind, tau,Ori,M,N,L,adapt)
load([kind, '_L=', num2str(L), '_K=', num2str(shots)]);
% gdmd = gdmd(1:128,1:128,1:11,:); %descomentar para 
% load('Enrique.mat');
% ind = round(linspace(1,31,12));
% hyperimg = double(hyperimg(:,:,ind));
% hyperimg = imresize(double(hyperimg),0.25);
% [a,b,c]=size(hyperimg);
hyperimg = Ori;
H_dmd=1;
H=L;
H1 = H/H_dmd;
shift = H_dmd;
Img=[];
Tra=0.5;

% gdmd = zeros(M,N,L,shots);
% for i=1:shots
%     for d=1:L
%         gdmd(:,:,d,i) = 1*(rand(M,N)<Tra(1));
%     end
% end
% save('random_feathers_K=4_L=31.mat','gdmd');

for uu=1:shots
    for vv=1:L
        dmd =zeros(N,M+L-1);
        dmd(:,1+(vv-1):M+(vv-1)) =gdmd(:,:,vv,uu);
        CC{uu,vv} = dmd;
        %filtro{uu} = CC{uu}
    end
end

for j=1:shots
    graydmd{j} = gdmd(:,:,1,j)/max(gdmd(:));
    %w{j} = ones(M,N); % weight matrix
    %w1{j} = ones(M,N); % weight matrix
end

%% Sensing process
y2=[];
y3=[];
satmax = (2^16)-1;

j = 1; %primero del for
% imagesc(gdmd(:,:,1,j))
y=multishot(N,H_dmd,H,H1,gdmd(:,:,:,j),hyperimg,shift);
% imagesc(y>=satmax)
y = y(:);   % Measurement in vector form
%y3 = [y3;y];
id = y > satmax;
cont = sum(y > satmax)
Sat = cont/numel(y)
y(id) = satmax;
%y= reshape(y,[M N+L-1]);
%imshow((y/max(y(:))).^0.5)
%ymed = inpaint_nans(reshape(y,[M N+L-1]),2);
ymed = medfilt2(reshape(y,[M N+L-1]));

end