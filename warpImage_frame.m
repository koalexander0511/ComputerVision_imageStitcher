function [warpIm, mergeIm] = warpImage_frame(inputIm, refIm, H)
    [refRow, refCol, ~] = size(refIm);
    [inputRow, inputCol, ~] = size(inputIm);
    
    inputImCornerX = [1   1       inputCol inputCol];
    inputImCornerY = [1 inputRow     1     inputRow];
    borders = H*[inputImCornerX;inputImCornerY;1 1 1 1];
    borders = borders./borders(3,:);
    %check border values of warped images
    min_X = min(borders(1,:));
    min_Y = min(borders(2,:));
    max_X = max(borders(1,:));
    max_Y = max(borders(2,:));
    %check if reference Image borders go out of border
    min_X = min(min_X,1);
    min_Y = min(min_Y,1);
    max_X = max(max_X, refCol);
    max_Y = max(max_Y, refRow);
    
    [inputX, inputY] = meshgrid(1:inputCol, 1:inputRow);
    
    [refX, refY] = meshgrid(min_X:max_X, min_Y:max_Y);
    [boundRow, boundCol, ~] = size(refX);
    
    refX_flat = reshape(refX, 1, []);
    refY_flat = reshape(refY, 1, []);
    
    refPts = [refX_flat;refY_flat;ones(1, boundCol*boundRow)];
    refPts_warp = inv(H)*refPts;
    refPts_warp = refPts_warp./refPts_warp(3,:);
    
    refX_warp = reshape(refPts_warp(1,:), boundRow, []);
    refY_warp = reshape(refPts_warp(2,:), boundRow, []);
    
    I_R = interp2(inputX, inputY, double(inputIm(:,:,1)),refX_warp,refY_warp);
    I_G = interp2(inputX, inputY, double(inputIm(:,:,2)),refX_warp,refY_warp);
    I_B = interp2(inputX, inputY, double(inputIm(:,:,3)),refX_warp,refY_warp);
    mergeIm = uint8(zeros(size(refX)));
    mergeIm(:,:,1) = uint8(I_R);
    mergeIm(:,:,2) = uint8(I_G);
    mergeIm(:,:,3) = uint8(I_B);
    min_Y_mag = abs(floor(min_Y));
    min_X_mag = abs(floor(min_X));
    warpIm = mergeIm(min_Y_mag:min_Y_mag+refRow-1, min_X_mag:min_X_mag+refCol-1, :);
    mergeIm = refIm;
    for i = 1:refRow
        for j = 1:refCol
            if(warpIm(i,j,1) ~= 0)
                mergeIm(i,j,:) = warpIm(i,j,:);
            end
        end
    end
    
    imshow(mergeIm);
    pause;
end