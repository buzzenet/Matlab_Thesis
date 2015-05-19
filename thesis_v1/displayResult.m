figure;

for i=2:size(gframes, 3)
    
    [y_pos, x_pos] = find(object(:,:,2));
    if (size(y_pos,1) == 0)
        y_pos = 0;
    end
    if (size(x_pos,1) == 0)
        x_pos = 0;
    end
    
    height = (max(x_pos) - min(x_pos));
    width = (max(y_pos) - min(y_pos));
    x_pos = min(x_pos);
    y_pos = min(y_pos);
    dataAxes = axes;
    subplot(1,3,1), imshow(gframes(:,:,i), []);
    if x_pos ~= 0 && y_pos ~= 0 && height ~= 0 && width ~= 0
        rectangle('Position',[x_pos y_pos height width],...
            'EdgeColor',[1 0 0],'LineWidth',2);
    end
    title('Grayscale Image');
    subplot(1,3,2), imshow(fmask(:,:,i), []);
    title('Frame Difference');
    subplot(1,3,3), imshow(object(:,:,i), []);
    title('Region Growing');
    pause(0.05);
    
    if i == 90
        disp hi;
    end
    
end