function S = LGP_Restoration(Im, kernel, lambda, kappa, lambda_lgp, betamax)
%%
% You can find that our code is based on dark channel prior code of Pan et
% al. Thus, we strongly recommand you read previous code before reading our code. 
% We really appreciate that they open source their code, so we also open
% source our code. Hope it can help you.
%% Input:
% @Im: Blurred image
% @kernel: blur kernel
% @lambda: weight for the L0 prior
% @kappa: Update ratio in the ADM
%% Output:
% @S: Latent image
%
% The Code is created based on the method described in the following paper 
%   [1] Jinshan Pan, Zhe Hu, Zhixun Su, and Ming-Hsuan Yang,
%        Deblurring Text Images via L0-Regularized Intensity and Gradient
%        Prior, CVPR, 2014. 
%   [2] Li Xu, Cewu Lu, Yi Xu, and Jiaya Jia. Image smoothing via l0 gradient minimization.
%        ACM Trans. Graph., 30(6):174, 2011.
%   [3] Chen, L. and Fang, F. and Wang, T. and Zhang, G. 
%        Blind image deblurring with local maximum gradient prior, Proc.
%        IEEE CVPR,2019, pp: 1742-1750.

if ~exist('kappa','var')
    kappa = 2.0;
end
%% pad image
H = size(Im,1);    W = size(Im,2);
Im = wrap_boundary_liu(Im, opt_fft_size([H W]+size(kernel)-1));
%%
S = Im;
fx = [1, -1];
fy = [1; -1];
[N,M,D] = size(Im);
sizeI2D = [N,M];
otfFx = psf2otf(fx,sizeI2D);
otfFy = psf2otf(fy,sizeI2D);

aver = 1/8 * [1,1,1;1,0,1;1,1,1];
otfP = psf2otf(aver,sizeI2D);
%%
KER = psf2otf(kernel,sizeI2D);
Den_KER = abs(KER).^2;
%%
Denormin2 = abs(otfFx).^2 + abs(otfFy ).^2;
if D>1
    Denormin2 = repmat(Denormin2,[1,1,D]);
    KER = repmat(KER,[1,1,D]);
    Den_KER = repmat(Den_KER,[1,1,D]);
end
Normin1 = conj(KER).*fft2(S);
%% 
beta = 2*lambda;
N = ceil(log2(betamax/beta));
n = 0;
while beta < betamax
    n = n + 1;
    Normin3 = conj(otfFx).*(otfP+conj(otfP)).*otfFx + ...
        conj(otfFy).*(otfP+conj(otfP)).*otfFy;
    Denormin   = Den_KER + beta*Denormin2 - (max(log2(beta),1)/log2(betamax)) * lambda_lgp*Normin3;
    
    h = [diff(S,1,2), S(:,1,:) - S(:,end,:)];
    v = [diff(S,1,1); S(1,:,:) - S(end,:,:)];
    if D==1
        t = (h.^2+v.^2)<lambda/beta;
    else
        t = sum((h.^2+v.^2),3)<lambda/beta;
        t = repmat(t,[1,1,D]);
    end
    h(t)=0; v(t)=0;
    Normin2 = [h(:,end,:) - h(:, 1,:), -diff(h,1,2)];
    Normin2 = Normin2 + [v(end,:,:) - v(1, :,:); -diff(v,1,1)];
    FS = (Normin1 + beta*fft2(Normin2))./Denormin;
    S = real(ifft2(FS));
    beta = beta*kappa;
    
end
S = S(1:H, 1:W, :);
end
