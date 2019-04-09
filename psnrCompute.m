function [r]=psnrCompute(A,ref)
for i=1:11
    r(i)=psnr(mat2gray(A(:,:,i)),mat2gray(ref(:,:,i)));
end
m = mean(r);
end