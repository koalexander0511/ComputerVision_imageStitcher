function [pts1, pts2] = getPoints(img1, img2, n)
    pts1 = zeros(2,n);
    pts2 = zeros(2,n);
    for i=1:n
        imshow(img1);
        pts1(:,i) = ginput(1);
        close;
        imshow(img2);
        pts2(:,i) = ginput(1);
        close;
    end
end