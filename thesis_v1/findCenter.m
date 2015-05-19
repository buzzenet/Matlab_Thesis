point = zeros(2,size(gframes, 3));
vel = point;
ylim = size(gframes,1);

for i=2:40
    [rowpx colpx] = find(object(:,:,i));
    point(1,i) = round(mean(mean(colpx)));
    point(2,i) = round(mean(mean(rowpx)));
end

figure;
imshow(object(:,:,40));
hold on;
for i=2:40
    plot(point(1,i), point(2,i), 'o', 'MarkerFaceColor', [1 0 0], 'MarkerSize', 8);
end
hold off;

for i=2:40
	u_temp = u(:,:,i) .* object(:,:,i);
	v_temp = v(:,:,i) .* object(:,:,i);
	
    vel(1,i) = mean(mean(u_temp));
    vel(2,i) = mean(mean(v_temp));
end

dt = 1/nfps*16;
[point_pred vel_pred] = KalmanFilter_Track(point, vel, [1 0 dt 0; 0 1 0 dt; 0 0 1 0; 0 0 0 1], [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1], [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1], [0 0 0 0; 0 0 0 0; 0 0 0 0; 0 0 0 0], [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1], 40);

figure;
plot(point(1,2:40), (ylim*ones(1,39)) - point(2,2:40), 'LineWidth', 2);
hold on;
plot(point(1,2)*ones(1,40) + (0:(point(1,3) - point(1,2)):39*2), (ylim - point(2,2))*ones(1,40), 'r');
plot(point_pred(1,2:40), (ylim*ones(1,39)) - point_pred(2,2:40), 'g', 'LineWidth', 2.5);
axis([0 size(gframes,2) 0 1*size(gframes,1)]);
legend('Measured Data', 'Actual Path', 'Predicted Path');
hold off;