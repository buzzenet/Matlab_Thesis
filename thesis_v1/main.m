    % load 'C:/users/jian wu/downloads/[thesis] OF Results/mat.mat';
% % load 'C:/users/jian wu/downloads/OF_billiard.mat';
load 'c:/users/jjs/desktop/particle_billiard';
% 
BGS_hist;
% try1;
% 
t = size(gframes,3);
segment_gs = zeros(size(gframes));
% segment_mag = zeros(size(gframes));

for i=2:t;
%     segment_mag(:,:,i) = RegionGrowing(mag(:,:,i), fmask(:,:,i), 0.03);
    segment_gs(:,:,i) = RegionGrowing(gframes(:,:,i), fmask(:,:,i), 0.03);
    fprintf('Frame %d of %d\n', i, t);
end