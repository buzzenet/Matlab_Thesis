[row, col, t] = size(gframes);
% gframes = zeros(row, col, t);
gframes_r2 = zeros(row/2, col/2, t);
gframes_r4 = zeros(row/4, col/4, t);

for i=1:t
gframes_r2(:,:,i) = imresize(gframes(:,:,i),0.5);
end
for i=1:t
gframes_r4(:,:,i) = imresize(gframes(:,:,i),0.25);
end

%%
% tic;
% u = zeros(size(gframes));
% v = u;
% for i=2:t
% [u(:,:,i), v(:,:,i)] = LucasKanade(gframes(:,:,i-1), gframes(:,:,i), 3);
% fprinstf('Frame %d of %d\n', i, t);
% end
% fprintf('---------------------------------------------\n');
% toc;

% tic;
u_r2 = zeros(size(gframes,1)/2, size(gframes,2)/2, t);
v_r2 = u_r2;
for i=2:t
[u_r2(:,:,i), v_r2(:,:,i)] = LucasKanade(gframes_r2(:,:,i-1), gframes_r2(:,:,i), 3);
fprintf('Frame %d of %d\n', i, t);
end
fprintf('---------------------------------------------\n');
% toc;

% tic;
u_r4 = zeros(size(gframes,1)/4, size(gframes,2)/4, t);
v_r4 = u_r4;
for i=2:t
[u_r4(:,:,i), v_r4(:,:,i)] = LucasKanade(gframes_r4(:,:,i-1), gframes_r4(:,:,i), 3);
fprintf('Frame %d of %d\n', i, t);
end
% toc;

%%
% mag = zeros(size(gframes));
% dir = mag;
% for i=1:t
% mag(:,:,i) = sqrt(u(:,:,i).^2 + v(:,:,i).^2);
% dir(:,:,i) = atan(v(:,:,i)./u(:,:,i));
% end

mag_r2 = zeros(size(gframes_r2));
dir_r2 = mag_r2;
for i=1:t
mag_r2(:,:,i) = sqrt(u_r2(:,:,i).^2 + v_r2(:,:,i).^2);
dir_r2(:,:,i) = atan(v_r2(:,:,i)./u_r2(:,:,i));
end

mag_r4 = zeros(size(gframes_r4));
dir_r4 = mag_r4;
for i=1:t
mag_r4(:,:,i) = sqrt(u_r4(:,:,i).^2 + v_r4(:,:,i).^2);
dir_r4(:,:,i) = atan(v_r4(:,:,i)./u_r4(:,:,i));
end

% figure;
% for i=1:t
% imshow([gframes_r2(:,:,i) mag_r2(:,:,i)]);
% pause(0.03);
% end