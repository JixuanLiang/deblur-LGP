map_clear = [];
map_blur = [];
mat1 = load('im01_ker08.mat');
f = waitbar(0,'Processing...');
for i = 1:4331
    n = floor(log10(i))+1; % image number
    numstr = num2str(i,'%06u');
    filename = ['.\data\VOCdevkit\VOC2012\JPEGImages\2012_', numstr, '.jpg'];
    if isfile(filename)
        img = imread(filename);
        img_gray = im2double(rgb2gray(img));
        [gx, gy] = gradient(img_gray);
        map2 = grad_product(gx,gy);
        map_clear = [map_clear, mean(map2(:))];
        
        img_blur = conv2(img_gray, mat1.f, 'same');
        [bx, by] = gradient(img_blur);
        map2 = grad_product(bx,by);
        map_blur = [map_blur, mean(map2(:))];
        
    end
    waitbar(i/4331,f,['Processing: Image ',num2str(i)]);
end

close(f)

%% histogram

edges = [-0.01:0.0005:0.08];
histogram(map_clear,edges,'LineStyle','none')
hold on
histogram(map_blur,edges,'LineStyle','none')
min(map_blur)
legend('Clear images','Blurred images');
% title('LGP statistic of clear images and blur images in VOC2012')
xlabel('Average local gradient product')
ylabel('number of images')

%% intensity histogram

edges = 0:0.0005:0.08;
histogram(map_clear,edges,'LineStyle','none')
hold on
histogram(map_blur,edges,'LineStyle','none')
min(map_blur)
legend('Clear images','Blurred images');
% title('LGP statistic of clear images and blur images in VOC2012')
xlabel('Intensity')
ylabel('Average value of local gradient product')
