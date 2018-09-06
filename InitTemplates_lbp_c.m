function [T,T_norm,T_mean,T_std] = InitTemplates_lbp_c(tsize, img_name, cpt)
% generate templates from single image
%   (r1,c1) ***** (r3,c3)            (1,1) ***** (1,cols)
%     *             *                  *           *
%      *             *       ----->     *           *
%       *             *                  *           *
%     (r2,c2) ***** (r4,c4)              (rows,1) **** (rows,cols)
% r1,r2,r3;
% c1,c2,c3

%% prepare templates geometric parameters
p{1}= cpt;
p{2} = cpt + [-1 0 0; 0 0 0];
p{3} = cpt + [1 0 0; 0 0 0];
p{4} = cpt + [0 -1 0; 0 0 0];
p{5} = cpt + [0 1 0; 0 0 0];
p{6} = cpt + [0 0 1; 0 0 0];
p{7} = cpt + [0 0 0; -1 0 0];
p{8} = cpt + [0 0 0; 1 0 0];
p{9} = cpt + [0 0 0; 0 -1 0];
p{10} = cpt + [0 0 0; 0 1 0];
%%
% p{1} = cpt + [30 30 30; 0 0 30];
% p{2} = cpt + [10 10 10; 0 0 10];
% p{3} = cpt + [50 50 50; 0 0 50];
% p{11} = cpt + [0 0 0; 0 0 -1];
% p{12} = cpt + [0 0 0; 0 0 1];
% p{13} = cpt + [-2 0 0; 0 0 0];
% p{14} = cpt + [2 0 0; 0 0 0];
% p{15} = cpt + [0 -2 0; 0 0 0];
% p{16} = cpt + [0 2 0; 0 0 0];
% p{17} = cpt + [0 0 -2; 0 0 0];
% p{18} = cpt + [0 0 2; 0 0 0];
% p{19} = cpt + [0 0 0; -2 0 0];
% p{20} = cpt + [0 0 0; 2 0 0];
% p{21} = cpt + [0 0 0; 0 -2 0];
% p{22} = cpt + [0 0 0; 0 2 0];
% p{23} = cpt + [0 0 0; 0 0 -2];
% p{24} = cpt + [0 0 0; 0 0 2];
% p{25} = cpt + [-3 0 0; 0 0 0];
% p{26} = cpt + [3 0 0; 0 0 0];
% p{27} = cpt + [0 -3 0; 0 0 0];
% p{28} = cpt + [0 3 0; 0 0 0];
% p{29} = cpt + [0 0 -3; 0 0 0];
% p{30} = cpt + [0 0 3; 0 0 0];

%% Initializating templates and image
T	= zeros(prod(tsize),10); % 196 for size 16*16; 900 for size 32*32
T_norm = zeros(1,10);
T_mean = zeros(1,10);
T_std = zeros(1,10);
% nz	= strcat('%0',num2str(numzeros),'d');
% image_no = sfno;
% fid = sprintf(nz, image_no);
% img_name = strcat(fprefix,fid,'.',fext);

img = imread(img_name);
if(size(img,3) == 3)
    img = double(rgb2gray(img));
end

%% cropping and normalizing templates
for n=1:10
    [T(:,n),T_norm(n),T_mean(n),T_std(n)] = ...
		corner2lbp(img, p{n}, tsize);   
end
T = qr(T);