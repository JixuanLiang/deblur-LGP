function impsnr = func_lgp_demo(lambda_lgp, im, ker, ksize, bw, betamax, thresh)
% clear;
close all;

addpath(genpath('whyte_code'));
addpath(genpath('cho_code'));
addpath(genpath('chen code'));

% fill folder location of Kohler files in ... place
% Recording and playback of camera shake: benchmarking blind deconvolution with a real-world database
% Köhler R, Hirsch M, Mohler B, et al. 
% https://webdav.tuebingen.mpg.de/pixel/benchmark4camerashake/#Downl_png_deblur

addpath(genpath('...\evaluation_code\'));
addpath(genpath('...\evaluation_code\BlurImg\'));
addpath(genpath('...\evaluation_code\groundTruthMatFiles\'));


opts.prescale = 1; %%downsampling
opts.xk_iter = 5 ; 
opts.gamma_correct = 1.0;
opts.k_thresh = 20;

opts.kernel_size = ksize;  saturation = 0;

opts.bw = bw;
lambda_grad =4e-3; opts.gamma_correct = 1;
lambda_tv = 0.001; lambda_l0 = 5e-4; weight_ring = 1;

y = imread(['Blurry', num2str(im), '_' num2str(ker), '.png']);

if size(y,3)==3
    yg = im2double(rgb2gray(y));
else
    yg = im2double(y);
end
%% 
tic;
opts.bwnum = thresh;
[kernel, interim_latent] = LGP_blind(yg, lambda_grad, opts, lambda_lgp, betamax);
toc

%% 
y = im2double(y);
Latent = ringing_artifacts_removal(y, kernel, 2e-3, 1e-3, 0);

figure; imshow(Latent)
imwrite(Latent,['.\kohler_results\',num2str(im), '_', num2str(ker), '.png']);
k = kernel/max(kernel(:));
imwrite(k,['.\kohler_results\', num2str(im), '_', num2str(ker), '_kernel', '.png']);
%% evaluate PSNR of the result, comment it out if you don't need it
impsnr = func_eval(im2uint8(Latent), im, ker);
% impsnr = 0;

