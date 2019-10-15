%part (a)
n = 5;
img1 = imread("im1.jpg");
img2 = imread("im2.jpg");
[t1 t2] = getPoints(img1, img2, n);

%part (b)
H = computeH(t1,t2);

[~, n] = size(t1);
w = ones(1,n);

t3 = H * [t1; w];
t3 = t3./t3(3,:);

subplot(2,2,[1 2])
imshow(img1)
title("Image 1 w/ t1 points")
hold on
scatter(t1(1,:), t1(2,:))

subplot(2,2,3)
imshow(img2)
title("Image 2 w/ t2 points")
hold on
scatter(t2(1,:), t2(2,:))

subplot(2,2,4)
imshow(img2)
title("Image 2 w/ tranformed t1 points")
hold on
scatter(t3(1,:), t3(2,:))
hold off;
pause;
close;

%part (c)
%created warpImage.m. Nothing to Run.

%part (d)
crop1 = imread("crop1.jpg");
crop2 = imread("crop2.jpg");
load("cc1.mat");
load("cc2.mat");

cropH = computeH(cc1,cc2);
[warpCrop, mergeCrop] = warpImage(crop1, crop2, cropH);

wdc1 = imread("wdc1.jpg");
wdc2 = imread("wdc2.jpg");
load("points.mat");
wdcH = computeH(points1,points2);
[warpWdc, mergeWdc] = warpImage(wdc1, wdc2, wdcH);

%part (e)
my1 = imread("myimg1.jpg");
my2 = imread("myimg2.jpg");
my3 = imread("myimg3.jpg");
load("myPoints.mat");
load("myPoints2.mat");
myH = computeH(mypt1, mypt2);
[warpMy mergeMy] = warpImage(my1, my2, myH);
myH = computeH(mypt3, mypt4);
[warpMy2 mergeMy2] = warpImage(my3, mergeMy, myH);

%part (f)
bg = imread("myimg2.jpg");
frame = imread("nick.jpg");
load("frame.mat");
frameH = computeH_frame(f2, frame);
[warpF mergeF] = warpImage_frame(frame, bg, frameH);

%extra credit (b)
N = 500;
bg = imread("lucy.jpg");
frame = zeros(N,N,3);
load("surfacePts.mat");
surfaceH = computeH_surface(surf, N);
[warpS mergeS] = warpImage(bg, frame, surfaceH);
