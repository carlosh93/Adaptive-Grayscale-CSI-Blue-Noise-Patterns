function rst = mtimes(A,x)
M = A.M;
N = A.N;
L = A.L;
G = A.G;
ImG=A.ImG;
Ind=A.Ind;
shots=A.shots;
Val=A.Val;

if  A.adjoint == 0 %A*x
    rst=[];
    x = reshape(x,M,N,L);
    x1=KronerDCTinverse(x,G,M,N,L);    
    x1=x1(:);
    x1(end+1)=0;
    
    for j=1:shots        
        Y=x1(Ind{j}).*(Val{j});
        sal=sum(Y,2);
        sal=sal(:);
        rst=[rst;sal];
    end
else %At*x
    Aux=zeros(1,M*N*L);
    coord1=[];
    coord2=[];
    coord3=[];
    
    for j=1:shots
        temp=ImG{j};
        coord1=[coord1;temp{1}(:)+(j-1)*length(x)/shots];
        coord2=[coord2;temp{2}(:)];
        coord3=[coord3;temp{3}(:)];
    end
    Aux = accumarray(coord2, x(coord1).*coord3);
    Aux(end+1:M*N*L)=0;
    
    rst=KronerDCTdirect(Aux,G,M,N,L);    
    rst=rst(:);
end
