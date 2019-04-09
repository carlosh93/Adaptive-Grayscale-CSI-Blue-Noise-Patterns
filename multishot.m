function y2=multishot(N,H_dmd,H,H1,gdmd,hyperimg,shift)
dmd = zeros(N,N,H_dmd);
% tile the aperture plane with 10000

dmd=gdmd;


dimg = zeros(N,N+H-1,H_dmd);
if size(dmd,3)==1
    for k = 1:H
        temp = zeros(N,N+H-1);
        temp(:,k:N+k-1) = hyperimg(:,:,k).*dmd(:,:);
        dimg(:,:) = dimg(:,:)+temp;
    end
else
    for k = 1:H
        temp = zeros(N,N+H-1);
        temp(:,k:N+k-1) = hyperimg(:,:,k).*dmd(:,:,k);
        dimg(:,:) = dimg(:,:)+temp;
    end
end


% measurement
%dimg = dimg;

%% reconstruction part
% 1) reorganize the measurement

rdimg = zeros(N,N+H-1,H_dmd);

y = zeros(N,N+shift*(H1-1),H_dmd);

for i = 1:H_dmd,
    for j = 1:H_dmd,
        m = mod(i+j-1,H_dmd);
        if m==0,
            m=H_dmd;
        end
        k = m:H_dmd:N+H-1;
        rdimg(:,k,i) = dimg(:,k,j);
    end
    y(:,:,i) = rdimg(:,i:N+H-1-(H_dmd-i),i);
end

y2 = y(:,:,1);%y(:,:,i) is for the i-th group