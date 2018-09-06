function [gly_crop, gly_inrange] = Seg_gly_crop_log(img_frame, curr_samples, template_size);
%create gly_crop, gly_inrange
nsamples = size(curr_samples,1);
for n = 1:nsamples
   %if mod(n,50)==0 fprintf('-'); end
   curr_afnv = curr_samples(n, :);
   [img_cut, gly_inrange(n)] = IMGaffine_r(img_frame, curr_afnv, template_size);
   sigma = 0.3;
   %gausFilter = fspecial('log',[8 8],sigma);
%    gausFilter = fspecial('sobel');
%    img_cut = imfilter(img_cut,gausFilter,'replicate');  
    hx = [-1 -2 -1;0 0 0 ;1 2 1];%生产sobel垂直梯度模板  
    hy = hx';                             %生产sobel水平梯度模板   
    gradx = imfilter(img_cut,hx);     
    grady = imfilter(img_cut,hy);    
    img_cut = sqrt(gradx.*gradx + grady.*grady);

    gly_crop(:,n) = reshape(img_cut, prod(template_size), 1);
end