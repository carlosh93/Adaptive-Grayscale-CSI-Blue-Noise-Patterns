function  obj = myHyperspectral_shiftKronmulti(G, M, N, L, dmd, ImG,Ind,Val,media,shots)
% with sparsity reduction in wavelet basis
obj.adjoint = 0;
obj.G = G;
obj.M = M;
obj.N = N;
obj.L = L;
obj.dmd = dmd;
obj.ImG=ImG;
obj.Ind=Ind;
obj.media=media;
obj.shots=shots;
obj.Val=Val;
obj = class(obj, 'myHyperspectral_shiftKronmulti');

