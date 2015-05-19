function [full_mask] = RegionGrowing(im_gray, im_seeds, thresh)

% [full_mask] = RegionGrowing(im_gray, im_seeds, thresh)
%
% This function constructs the object given a grayscale image
% and the seed points/pixels that it will use to form the object/s.
% The seeds point array should be the same size as the grayscale 
% image, and that it can include one or more seed points. 
% The position of the seed points should be maked with 
% 1 (true) in the seed array. The basis for determining the 
% included neighboring pixels is based on the threshold (thresh).
% 
% full_mask = Result of Region Growing
% im_gray = Grayscale Image
% im_seeds = Image Seeds
% thresh = Threshold Value Used
% 
% Coded by: Karl Joseph Palma Centillo

    dim = size(im_gray);
    [seedr, seedc] = find(im_seeds);
    full_mask = im_seeds;
    
%     disp(dim(1));
%     figure, imshow(im_seeds);
    
    while ~isempty(find(seedr, 1))
        temp_mat = zeros(10000, 2);
        index = 1;
        for a = 1:size(seedr)
            for r = -1:1
                for c = -1:1
                    if (seedr(a) + r <= dim(1) && seedc(a) + c <= dim(2) && seedr(a) + r > 0 && seedc(a) + c > 0)
                        if (abs(im_gray(seedr(a) + r, seedc(a) + c) - im_gray(seedr(a), seedc(a))) < thresh && ~full_mask(seedr(a) + r, seedc(a) + c))
                            full_mask(seedr(a) + r, seedc(a) + c) = true;   
                            if ~ismember([(seedr(a) + r) (seedc(a) + c)], temp_mat, 'rows')
                                temp_mat(index,:) = [seedr(a) + r, seedc(a) + c];
                                index = index + 1;
                            end
                        end
                    end
                end
            end
        end
        
        temp_mat = temp_mat(1:find(temp_mat(:,1), 1, 'last'), :);
%         disp(sum(sum(temp_mat)));
        seedr = temp_mat(:,1);
        seedc = temp_mat(:,2);    
%         disp(isempty(temp_mat));
%         figure, imshow(full_mask, []);
    end
end