function [y2]=multishot(N,H_dmd,H,H1,gdmd,hyperimg,shift)
%multishot - Function that simulates the C-CASSI sensing process.
%
% Syntax:  [y2] = multishot(N,H_dmd,H,H1,gdmd,hyperimg,shift)
%
% Inputs:
%    N - Spatial Dimensions of the spectral image (NxNxH)
%    H_dmd - 3rd Dimension of the dmd
%    H - Spectral dimension of the image
%    H1 - H/H_dmd
%    gdmd - 3D coded aperture
%    hyperimg - spectral image data
%    shift - spatial shifting of prism dispersion
% Outputs:
%    y2 - Compressive measurements
%
% Other m-files required: CASSI_process.m, fun_PSNR.m
%
% See also: CASSI_process.m,  fun_PSNR.m, multishot.m
% Author: Carlos Hinojosa, Nelson Diaz and Henry Arguello
% Universidad Industrial de Santander
% High Dimensional Signal Processing Group (HDSP)
% Research Group Website: http://hdspgroup.com
% Corresponding Author Email: nelson.diaz@saber.uis.edu.co
% Author Website: http://carlosh93.github.io
% April 9 2019; Last revision: 8-Apr-2019
%------------- BEGIN CODE --------------


dmd = zeros(N,N,H_dmd);

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

y2 = y(:,:,1);

%------------- END CODE --------------