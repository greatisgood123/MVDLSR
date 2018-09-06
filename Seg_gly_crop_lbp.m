function [L, gly_inrange] = Seg_gly_crop_lbp(img_frame, curr_samples, template_size)
%create gly_crop, gly_inrange

nsamples = size(curr_samples,1);
for n = 1:nsamples
   %if mod(n,50)==0 fprintf('-'); end
   curr_afnv = curr_samples(n, :);
   [img_cut, gly_inrange(n)] = IMGaffine_r(img_frame, curr_afnv, template_size);
%    img_cut1 = [zeros(1,16);img_cut;zeros(1,16)];
%    img_cut = [zeros(18,1),img_cut1, zeros(18,1)];  %矩阵扩充为了LBP输出结果与原图像大小对应
   SP = [-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
   H1 = double(LBP(img_cut,SP,0,'i'));
   [m, u] = size(H1);
   L(:,n) = reshape(H1, m*u,1);
end
