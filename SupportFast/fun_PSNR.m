function psnr = fun_PSNR(img,res)
[M,N]=size(img);
temp=1./(M*N)*sum(sum((img(:,:)-res(:,:)).^2));
psnr=10*log10(max(max(img(:,:).^2./temp)));