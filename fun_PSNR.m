function [temp] = fun_PSNR(img,res)

N=size(img,1);
temp=1./N.^2*sum(sum((img(:,:)-res(:,:)).^2));
temp=10*log10(max(max(img(:,:).^2./temp)));

end