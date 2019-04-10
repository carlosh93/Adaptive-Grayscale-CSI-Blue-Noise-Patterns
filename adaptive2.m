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
                DMD(i,1:j) = DMD(i,1:j) + 1;
                FPA(i,j) = sum(dmdf(i,1:j));
            elseif(j >= L && j <= N)
                DMD(i,j-(L-1):j) = DMD(i,j-(L-1):j) + 1;
                FPA(i,j) = sum(dmdf(i,j-(L-1):j));
            elseif(j > N)
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

ynew(id) = 0;

dmd = DMD';
dmd = dmd(:);
id = (1:L:N*M);

gdmd1 = zeros(1,M*N);
for i=1:length(id)-1
    n  = max(dmd(id(i):id(i+1)-1)); % The segment is saturated
    if (n ~= 0)
        gdmd1(id(i):id(i+1)-1) = ones(1,L);
    end
end
gdmd1 = reshape(gdmd1,[M,N])';
gdmd1 = (DMD>0);
gdmd = gdmd1.*(rand(M,N) > 0.5)*(9/256);
imagesc(gdmd+(~gdmd1.*dmdf))
dmdf = gdmd+(~gdmd1.*dmdf);
end