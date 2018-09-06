function [f_hog_crop, gly_inrange,Y_crop_mean, Y_crop_std] = Seg_gly_crop_hog(img_frame, curr_samples, template_size)
%create gly_crop, gly_inrange

nsamples = size(curr_samples,1);
%f_hog_crop = zeros(36,nsamples);
for n = 1:nsamples
   %if mod(n,50)==0 fprintf('-'); end
   curr_afnv = curr_samples(n, :);
   [img_cut, gly_inrange(n)] = IMGaffine_r(img_frame, curr_afnv, template_size);
   [f_hog_crop(:,n)] = image2hog(img_cut);
   %gly_crop(:,n) = reshape(img_cut, prod(template_size), 1);
end
Y_crop_mean = mean(f_hog_crop);
Y_crop_std = std(f_hog_crop)+1e-14;