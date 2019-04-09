function UW = KronerDCTdirect(Aux,G,M,N,L)

%  
% KronerDCTdirect.m
%
% This function performs the transformation to the Kronecker domain
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
%   Aux:    Datacube
%   G:      Wavelet Symmlet 8 filter
%   M:      Rows of Hyperspectral datacube
%   N:      Columns of Hyperspectral datacube 
%   L:      Bands of Hyperspectral datacube  
%
% 	===== Output =====
%   UW:     Direct Kronecker transformation
%
% ========================================================

Um = reshape(Aux, [M*N L])';
Ug = dct(Um);                            % Discrete cosine transform
U = reshape(Ug', [M N L]);
UW = U;

for i=1:L
    UW(:,:,i) = FWT2_PO(U(:,:,i), 1, G); % 2D Wavelet transform
end