clc;clear;
mat1 = load('im01_ker08.mat');
img = mat1.x;
figure(1)
subplot(221)
imshow(img);
title('Clear image')
subplot(223)
imshow(imadjust(mat1.f));
title('Blur kernel')

img_blr = mat1.y;
subplot(222)
imshow(img_blr)
title('Blurred image')

%% gradient

[px,py] = gradient(img);
figure(2)
subplot(121)
contour(img)
hold on
quiver(px,py)
hold off
axis ij
title('Gradient map of the clear image');

[gx,gy] = gradient(img_blr);
subplot(122)
contour(img_blr)
hold on
quiver(gx,gy)
hold off
axis ij
title('Gradient map of the blurred image')

figure(3)
subplot(121)
contour(img(170:200,85:110))
hold on
quiver(px(170:200,85:110),py(170:200,85:110))
hold off
axis ij
title('Gradient map of the selected area in the clear image');

subplot(122)
contour(img_blr(170:200,85:110))
hold on
quiver(gx(170:200,85:110),gy(170:200,85:110))
hold off
axis ij
title('Gradient map of the selected area in the blurred image');

%% intensity

figure(4)
subplot(221)
map1 = grad_product(px,py);
imshow(map1);
title('Local gradient product map of the clear image');
subplot(222)
map2 = grad_product(gx,gy);
imshow(map2);
title('Local gradient product map of the blurred image');
subplot(223);
imhist(map1);
subplot(224);
imhist(map2)

%% sparsity

figure(5)
subplot(121)
imshow(imadjust(map1))
title('Local gradient product map of the clear image(imadjust)');
subplot(122)
imshow(imadjust(map2))
title('Local gradient product map of the blurred image(imadjust)');

