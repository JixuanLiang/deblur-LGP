# deblur-LGP
Code to implement blind deblurring algorithm using local gradient product prior.
Wait for completely submission. 
Repository established on September 4, 2023.

Within our repository, you will find several important files:

1. **voc_distri.m**
   - This file corresponds to Fig. 3 in our paper.
   - To use this file, please download the VOC2012 dataset from the following link: [VOC2012 Dataset](http://host.robots.ox.ac.uk/pascal/VOC/voc2012/#devkit).

2. **grad_product.m**
   - This script takes the gradient map of an image as input and generates the local gradient product map of the image as output.

3. **LGP_comp.m**
   - In this file, we illustrate the differences between clear images and blurred images, including Fig. 1 in our work.

4. **im01_ker08.mat**
   - A image file in the Levin et al. dataset. (Understanding and evaluating blind deconvolution algorithms) 

Our research work has been submitted to ICASSP 2024. We are committed to making our complete code available as soon as our article is accepted by ICASSP(hope it's good enough).
If our submission is not accepted, the complete code will remain in a "coming soon" status. :P @_@ 

Good news! Our paper has been accepted by ICASSP 2024. As mentioned before, we open source our code so that everyone can verify and may conduct their own research based on it. If you have any questions, please contact us. The code may be supplemented in the future. (20231226)

**demo_LGP_kohler.m**
- This file realizes our blind deblurring algorithm on Kohler et al. dataset.

**func_lgp_demo.m**
- Before running this file, you need to download necessary data at https://webdav.tuebingen.mpg.de/pixel/benchmark4camerashake/#Downl_png_deblur.
- You need to fill folder location in ... place, so that you can get PSNR values of deblurred results.
- If you only want image results without evaluating them, you can remove evaluating code containing func_eval.m.
- If you want other terms like SSIM, try to run eval_image.m from Kohler et al. dataset.


