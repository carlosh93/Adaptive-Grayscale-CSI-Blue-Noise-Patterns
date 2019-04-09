function [H1,Img,Ind,Val] = Atranspose(M,N,L,dmd,Sh,ind,adaptive)

at=[]; bt=[]; vt=[];
for r=1:L
    img = dmd{r};
    [a,b,v] = find(img);
    ax = a(:) + (b(:)-1)*M;
    bx = (r-1)*(M*N) + (b(:)-1-(r-1))*M+a(:);
    at = [at; ax(:)];
    bt = [bt; bx(:)];
    vt = [vt; v(:)];
end

H = sparse(at,bt,vt,Sh,M*N*L);
if (adaptive == 1)
    H(ind,:) = 0;
end

%%
factor=1;
D = Down( M,N,L, factor );
H1 = [];
H1 = [H1; H*D'];

[R1,R2,R3] = find(H1);
Img=[]; Img{1}=R1; Img{2}=R2; Img{3}=R3;    

%% Compact
[M1,L2]=sort(R1);
M2=R2(L2(:));
M3=R3(L2(:));

cont=1; cont2=1;
Ind=ones(Sh,L)*(M/factor*N/factor*L+1);
Val=zeros(Sh,L);

while cont2<=length(R1)
    k=1;
    Ind(M1(cont2),k)=M2(cont2);
    Val(M1(cont2),k)=M3(cont2);
    
    if (cont2<length(R1))
        while (M1(cont2)==M1(cont2+1))
            Ind(M1(cont2),k+1)=M2(cont2+1);
            Val(M1(cont2),k+1)=M3(cont2+1);
            
            cont2=cont2+1;
            k=k+1;
            if cont2>=length(R1)
                break;
            end
        end
    end
    
    cont2=cont2+1;
    cont=cont+1;
end


