clear;

%% Initialization and parameters
nT			= 11;		%number of T
n_sample	= 400;		%number of particles

res_path	= 'result\animal\'; 

%preparing frames
fprefix		= 'animal\frame_';
fext		= 'jpg';				
start_frame	= 1;					 
nframes		= 70;					
sz_T		= [16,16];	
numzeros	= 4;	
afnv = [0.005,0.0005,0.0005,0.005,4,4];   % choose different value for different sequence
threshold = 5;  % choose different value for different sequence

s_frames	= cell(nframes,1);

nz			= strcat('%0',num2str(numzeros),'d'); %number of zeros in the name of image %保留5位整数
for t=1:nframes
    image_no	= start_frame + (t-1);
    fid			= sprintf(nz, image_no);
    s_frames{t}	= strcat(fprefix,fid,'.',fext);
end

%initialization
%	init_pos	- target selected by user (or automatically), it is a 2x3
%		matrix, such that each COLUMN is a point indicating a corner of the target
%		in the first image. Let [p1 p2 p3] be the three points, they are
%		used to determine the affine parameters of the target, as following
% 			   p1(306,5)-----------p3(401,5)
        %         | 				|		 
        %         |     target      |
        %         | 				|	        
        %   p2(306,70)--------------


  init_pos	= [5,70,5;
                 306,306,401];   % for animal 1st frame 
   
%% L1 tracking

[tracking_res coordinate] = L1Tracking_release_threeview_joint_clutter( s_frames, sz_T, n_sample, init_pos,afnv,threshold); % for three-view with clutter

%% Estimate the overlapping rate
load groundtruth_animal.txt;
groundtruth = groundtruth_animal;    %
estimate = coordinate; 
[m n] = size(estimate);
gtLength = nframes;
overlapRate = zeros(1, nframes);
overlapRate(1) = 1.0;
for i = 2:gtLength
    x1 =[groundtruth(i,1) groundtruth(i,1)+groundtruth(i,3) groundtruth(i,1)+groundtruth(i,3) groundtruth(i,1) groundtruth(i,1);
           groundtruth(i,2) groundtruth(i,2) groundtruth(i,2)+groundtruth(i,4) groundtruth(i,2)+groundtruth(i,4) groundtruth(i,2) ];
%     x1 =[groundtruth(i,1) groundtruth(i,3) groundtruth(i,3) groundtruth(i,1) groundtruth(i,1);
%            groundtruth(i,2) groundtruth(i,2) groundtruth(i,4) groundtruth(i,4) groundtruth(i,2) ];   % for basketball et.al
    x2 = [estimate(i,1) estimate(i,1)+estimate(i,3)  estimate(i,1)+estimate(i,3) estimate(i,1)  estimate(i,1);
             estimate(i,2) estimate(i,2) estimate(i,2)+estimate(i,4) estimate(i,2)+estimate(i,4) estimate(i,2) ];
    overlapRate(i) = calculateOverlapRate(x1,x2,  'quadrilateral');
end
aver_overlapRate = sum(overlapRate)/gtLength;
mSuccessRate = sum(overlapRate>0.5)/length(overlapRate);

for t = 1:nframes
    img_color	= imread(s_frames{t});
    img_color	= double(img_color);
    imshow(uint8(img_color));
    text(15,30,num2str(t),'FontSize',20,'Color','r');
    color = [1 0 0];
    map_afnv	= tracking_res(:,t)';
    drawAffine(map_afnv, sz_T, color, 2);
    
    s_res	= s_frames{t}(1:end-4);
    s_res	= fliplr(strtok(fliplr(s_res),'/'));
    s_res	= fliplr(strtok(fliplr(s_res),'\'));
    s_res	= [res_path s_res '_propose.tif'];
    saveas(gcf, s_res)

end



