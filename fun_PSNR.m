function [temp] = fun_PSNR(img,res)
   N=size(img,1); 
    temp=1./N.^2*sum(sum((img(:,:)-res(:,:)).^2));
    temp=10*log10(max(max(img(:,:).^2./temp)));

% N = length(img);
% o_max = max(img(:));
% o_min = min(img(:));
% a = res;
% a_max = max(a(:));
% a_min = min(a(:));
% p = (o_max-o_min)/(a_max-a_min);
% q = o_max-p*a_max;
% c = p*a+q;
% psnr = 20*log10(o_max/(norm(c(:)-img(:))/N));