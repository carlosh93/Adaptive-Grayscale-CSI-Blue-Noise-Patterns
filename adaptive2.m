function [dmdf,ynew]=adaptive2(y,M,N,L,dmdf,satmax)
y1 = reshape(y,[M,(N+L-1)]);
[ynew,dmdf]=detectSaturation(M,N,L,y1,satmax,dmdf);
end

function [ynew,dmdf]=detectSaturation(M,N,L,y1,satmax,dmdf)
DMD = zeros(M,N);
FPA = zeros(M,N+L-1);
ynew = zeros(M,N+L-1);
for j=1:N+(L-1)
    for i=1:M
        if(y1(i,j) >= satmax)
            if(j < L)
                %DMD(i,1:j) = DMD(i,1:j).*dmdf(i,1:j) + 1;
                DMD(i,1:j) = DMD(i,1:j) + 1;
                FPA(i,j) = sum(dmdf(i,1:j));
            elseif(j >= L && j <= N)
                %DMD(i,j-(L-1):j) = DMD(i,j-(L-1):j).*dmdf(i,j-(L-1):j) + 1;
                DMD(i,j-(L-1):j) = DMD(i,j-(L-1):j) + 1;
                FPA(i,j) = sum(dmdf(i,j-(L-1):j));
            elseif(j > N)
                %DMD(i,N-(L-1)+(j-N):N)= DMD(i,N-(L-1)+(j-N):N).*dmdf(i,N-(L-1)+(j-N):N)+1;
                DMD(i,N-(L-1)+(j-N):N)= DMD(i,N-(L-1)+(j-N):N)+1;
                FPA(i,j) = sum(dmdf(i,N-(L-1)+(j-N):N));
            end
        else
        end
    end
end
imagesc(y1>satmax)
imagesc(DMD)
id = find(FPA);
%ynew(id) =(satmax*((L/FPA(id)+eps)));
ynew(id) = 0;
%imagesc(ynew)
dmd = DMD';
dmd = dmd(:);
id = (1:L:N*M);
%gdmd = zeros(1,M*N);
gdmd1 = zeros(1,M*N);
for i=1:length(id)-1
    %idx = zeros(1,16);
    n  = max(dmd(id(i):id(i+1)-1)); % The segment is saturated
    if (n ~= 0)
        %Id = randperm(16,ceil(L/(n+3))); %
        %idx(Id) = 1/n; %
        %gdmd(id(i):id(i+1)-1) = idx;
        gdmd1(id(i):id(i+1)-1) = ones(1,L);
    end
end
%gdmd = reshape(gdmd,[M,N])';
gdmd1 = reshape(gdmd1,[M,N])';
gdmd1 = (DMD>0);
%gdmd = gdmd1.*(dmdf > 0)*(9/256);%(9/256); 
gdmd = gdmd1.*(rand(M,N) > 0.5)*(9/256);%(9/256); 
imagesc(gdmd+(~gdmd1.*dmdf))
dmdf = gdmd+(~gdmd1.*dmdf);
end