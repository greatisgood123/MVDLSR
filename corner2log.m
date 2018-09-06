function [gly_crop,gly_crop_norm,gly_crop_mean,gly_crop_std] = corner2log(img, p, tsize)
%   (r1,c1) ***** (r3,c3)            (1,1) ***** (1,cols)
%     *             *                  *           *
%      *             *       ----->     *           *
%       *             *                  *           *
%     (r2,c2) ***** (r4,c4)              (rows,1) **** (rows,cols)
afnv_obj = corners2afnv( p, tsize);
%afnv_obj = corners2afnv( [r1,r2,r3;c1,c2,c3], tsize);
map_afnv = afnv_obj.afnv;
img_map = IMGaffine_r(img, map_afnv, tsize);
sigma = 0.3;
%gausFilter = fspecial('log',[8 8],sigma);
% gausFilter = fspecial('sobel');
% img_map = imfilter(img_map,gausFilter,'replicate');
    hx = [-1 -2 -1;0 0 0 ;1 2 1];%生产sobel垂直梯度模板  
    hy = hx';                             %生产sobel水平梯度模板   
    gradx = imfilter(img_map,hx);     
    grady = imfilter(img_map,hy);    
    img_map = sqrt(gradx.*gradx + grady.*grady);   
% imshow(img_map,[]);
[gly_crop,gly_crop_mean,gly_crop_std] = gly_zmuv( reshape(img_map, prod(tsize), 1) ); %gly_crop is a vector
%gly_crop_norm = sqrt(sum(gly_crop.*gly_crop));
%gly_crop = gly_crop/(ones(size(gly_crop,1),1)*gly_crop_norm);
gly_crop_norm = norm(gly_crop);
gly_crop = gly_crop/gly_crop_norm;
