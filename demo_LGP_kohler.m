%% code for Levin et al. dataset
grad = 3 * 1e-4;
psnrmatrix2 = [];
for im = 1:4
    for ker = 1:12
        psnrarr = [];
        bw = 1;
        betamax = 2^16;
        th = 0.1;
        if ker == 8
            ksize = 121;
        elseif ker == 9
            ksize = 125;
            bw = 0;
        elseif ker == 10
            ksize = 151;
        elseif ker == 11
            ksize = 75;
        else
            ksize = 41;
        end
        
        if im == 2 && ker == 9
            betamax = 2^14;
        end
        if im == 2 && ker == 10
            th = 0.05;
        end
        
        tmp = func_lgp_demo(grad, im, ker, ksize, bw, betamax, th);
        psnrarr = [psnrarr, tmp];
        
        psnrmatrix2 = [psnrmatrix2;psnrarr];
    end
end








