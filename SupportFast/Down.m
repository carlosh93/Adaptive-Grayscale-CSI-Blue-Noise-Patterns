function H = Down( M,N,L, factor )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%[M,N,L] = size(X);

f = ones(factor,factor);

M1 = floor(M/factor);
N1 = floor(N/factor);

V = 1:N*M;

V = reshape(V,[M,N]);

U = zeros(size(V));

cont = 1;

for j=1:M1
    for i=1:N1
        U(1+(i-1)*factor:i*factor,1+(j-1)*factor:j*factor) = cont*f;
        cont = cont + 1;
    end
end

U = U(1:M,1:N);

U = U(:);

V = V(:);

H1 = sparse(U,V,1,M1*N1,M*N);

H = [];

for i=1:L
    H = blkdiag(H,H1);
end

end

