clear all;
close all;
clc;

% load matlab.mat;
% tic;
disp('Start Loading...');
% vr = VideoReader('C:\Users\JJS\Dropbox\Matlab Thesis\Billiards1.avi');
% vr = VideoReader('C:\Users\JJS\Desktop\Billiards.avi');
% vr = VideoReader('C:\Users\JJS\Desktop\Molotov.avi');
% vr = VideoReader('C:\Users\JJS\Desktop\Road1.avi');
% vr = VideoReader('C:\Users\JJS\Desktop\Balloons.avi');
vr = VideoReader('C:\Users\JJS\Desktop\TrialVideos\MVI_1714.avi');
frames = read(vr);

nfps = vr.FrameRate;
nframes = vr.NumberOfFrames - 1;
delay = 1/nfps;
scale = 0.5;

gframes = zeros(size(frames,1)*scale, size(frames,2)*scale, nframes);
for i = 1:nframes
    gframes(:,:,i) = imresize((double(rgb2gray(frames(:,:,:,i))) / 2.^8), scale);
end

% % toc;
disp('Loading Finished');

% for i = 1:nframes
%     imshow(frames(:,:,:,i));
%     pause(delay);
% end
% 
% for i = 1:nframes
%     imshow(g_frames(:,:,i));
%     pause(delay);
% end
clear vr;
% save matlab.mat;

%% Algorithm - Frame Differencing with Region Growing for Flow Field Manipulation (Magnitude)
% figure('name', 'Background Subtraction');

fmask = zeros(size(gframes));
disp start;

% se = strel('diamond', 1);
se = strel('diamond', 1);
bthresh = 0.07;
bpixels = 20;

for i = 2:size(gframes, 3)
    fprintf('Frame %d\n', i);
%     [counts, x] = imhist(gframes(:,:,i) - gframes(:,:,i-1));
%     um = mean(counts.*x);
%     figure; 
    fmask(:,:,i) = (gframes(:,:,i) - gframes(:,:,i-1)) > bthresh;
%     fmask(:,:,i) = gframes(:,:,i-1) - gframes(:,:,i) < -1 * bthresh;
%     subplot(1,2,1),imshow(fmask(:,:,i), []);
    fmask(:,:,i) = imerode(fmask(:,:,i), se);
    fmask(:,:,i) = bwareaopen(fmask(:,:,i), bpixels);
%     fmask(:,:,i) = RegionGrowing(mag(:,:,i), fmask(:,:,i), 0.05);
%     fmask(:,:,i) = imfill(fmask(:,:,i), 'holes');
    
%     subplot(1,2,2),imshow(fmask(:,:,i), []);
%     figure; 
%     frame = gframes(:,:,i) - gframes(:,:,i-1);
    
%     subplot(1,2,1),imshow(frame, [0 1]);
%     subplot(1,2,2),stem(x, counts);
%     disp(um);
    
%     figure(1);
%     subplot(1,3,1), imshow(fmask(:,:,i)); title('I2-I1 > thresh');
%     subplot(1,3,2), imshow(fmask2); title('I1-12 < -thresh');
%     subplot(1,3,3), imshow(xor(fmask1, fmask2)); title('I1-12 < -thresh');
%     fprintf('%d\n', isequal(fmask1,fmask2));
%     pause(0.05);
end

% for i=1:size(fmask, 3)
%     imshow(fmask(:,:,i), []);
% %     imshow(g_frames(:,:,i), []);
%     pause(0.03);
% end

disp done;  