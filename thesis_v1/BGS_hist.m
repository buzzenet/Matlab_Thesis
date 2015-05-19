close all;
clc;

% load matlab.mat;
% tic;
% disp('Start Loading...');
% % vr = VideoReader('C:\Users\JJS\Dropbox\Matlab Thesis\Billiards1.avi');
% % vr = VideoReader('C:\Users\JJS\Desktop\Billiards.avi');
% % vr = VideoReader('C:\Users\JJS\Desktop\Molotov.avi');
% % vr = VideoReader('C:\Users\JJS\Desktop\Road1.avi');
% vr = VideoReader('C:\Users\JJS\Desktop\Balloons.avi');
% frames = read(vr);
% 
% nfps = vr.FrameRate;
% nframes = vr.NumberOfFrames - 1;
% delay = 1/nfps;
% 
% g_frames = zeros(size(frames,1)/2, size(frames,2)/2, nframes);
% for i = 1:nframes
%     g_frames(:,:,i) = imresize((double(rgb2gray(frames(:,:,:,i))) / 2.^8), 0.5);
% end
% 
% % toc;
% disp('Loading Finished');
% 
% for i = 1:nframes
%     imshow(frames(:,:,:,i));
%     pause(delay);
% end
% 
% for i = 1:nframes
%     imshow(g_frames(:,:,i));
%     pause(delay);
% end

% save matlab.mat;

%% Algorithm - Frame Differencing with Region Growing for Flow Field Manipulation (Magnitude)
% figure('name', 'Background Subtraction');

fmask = zeros(size(gframes));
disp start;

% se = strel('diamond', 1);
se = strel('diamond', 1);

for i = 2:size(gframes, 3)
    fprintf('Frame %d\n', i);
    [counts, x] = imhist(gframes(:,:,i) - gframes(:,:,i-1));
    um = mean(counts.*x);
%     figure; 
    fmask(:,:,i) = (gframes(:,:,i) - gframes(:,:,i-1)) > 0.05;
%     subplot(1,2,1),imshow(fmask(:,:,i), []);
    fmask(:,:,i) = imerode(fmask(:,:,i), se);
%     fmask(:,:,i) = RegionGrowing(mag(:,:,i), fmask(:,:,i), 0.05);
%     fmask(:,:,i) = imfill(fmask(:,:,i), 'holes');
    
%     subplot(1,2,2),imshow(fmask(:,:,i), []);
%     figure; 
%     frame = gframes(:,:,i) - gframes(:,:,i-1);
    
%     subplot(1,2,1),imshow(frame, [0 1]);
%     subplot(1,2,2),stem(x, counts);
%     disp(um);
    
%     pause;
end

% for i=1:size(mag, 3)
%     imshow(fmask(:,:,i), []);
% %     imshow(g_frames(:,:,i), []);
%     pause(0.03);
% end

disp done;