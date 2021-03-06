function [f_hog_crop,gly_crop_norm, gly_crop_std] = corner2hog(img, p, tsize)
%   (r1,c1) ***** (r3,c3)            (1,1) ***** (1,cols)
%     *             *                  *           *
%      *             *       ----->     *           *
%       *             *                  *           *
%     (r2,c2) ***** (r4,c4)              (rows,1) **** (rows,cols)
afnv_obj = corners2afnv( p, tsize);
%afnv_obj = corners2afnv( [r1,r2,r3;c1,c2,c3], tsize);
map_afnv = afnv_obj.afnv;
img_map = IMGaffine_r(img, map_afnv, tsize);

[f_hog_crop] = image2hog(img_map);
% [gly_crop,gly_crop_mean,gly_crop_std] = gly_zmuv( reshape(img_map, prod(tsize), 1) ); %gly_crop is a vector
%gly_crop_norm = sqrt(sum(gly_crop.*gly_crop));
%gly_crop = gly_crop/(ones(size(gly_crop,1),1)*gly_crop_norm);
gly_crop_norm = norm(f_hog_crop);
gly_crop_std = std(f_hog_crop)+1e-14;
%gly_crop_mean = f_hog_crop./gly_crop_norm;
