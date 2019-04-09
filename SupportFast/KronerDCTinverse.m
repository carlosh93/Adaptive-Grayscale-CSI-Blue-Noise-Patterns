function V2=KronerDCTinverse(UW,G,M,N,L)

%  
% KronerDCTinverse.m
%
% This function performs the transformation from the Kronecker domain
% composed by the Wavelet 2D and the DCT
%
% -----------------------------------------------------------------------
% Copyright (2012): Gonzalo R. Arce
% 
% CASSI_UD is distributed under the terms
% of the GNU General Public License 2.0.
% 
% Permission to use, copy, modify, and distribute this software for
% any purpose without fee is hereby granted, provided that this entire
% notice is included in all copies of any software which is or includes
% a copy or modification of this software and in all copies of the
% supporting documentation for such software.
% This software is being provided "as is", without any express or
% implied warranty.  In particular, the authors do not make any
% representation or warranty of any kind concerning the merchantability
% of this software or its fitness for any particular purpose."
% ----------------------------------------------------------------------
% 
%
%   ===== Required inputs =====
%
%   UW:     Kronecker transformed datacube
%   G:      Wavelet Symmlet 8 filter
%   M:      Rows of Hyperspectral datacube
%   N:      Columns of Hyperspectral datacube 
%   L:      Bands of Hyperspectral datacube  
%
% 	===== Output =====
%   V2:     Hyperspectral datacube
%
% ========================================================

for i=1:L
    UU(:,:,i) = IWT2_PO(UW(:,:,i), 1, G);   % Inverse 2D Wavelet transform
end

Vp=reshape(UU,[M*N L])';
U2=idct(Vp);               % Inverse Discrete Cosine transform
V2=reshape(U2',[M N L]);
