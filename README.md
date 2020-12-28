# Compressive Convolutional Network (CCN)
### Intruduction
The proposed algorithm of the Compressive Convolutional Network (CCN) features the ability to perform near-isometric compressive sensing using convolutional operations.
A novel incoherent convolution approach is invented for learning the embedded matrix to achieve near-isometric property for compressive sensing.

### **Dependencies**
+ Matlab
+ C++

### **Run Compressive Convolutional Network**
`FrontEnd_Detection&Compression` is the training code, which is modified from the official public YOLOv2 code.
`Demo.m` is a demo to reconstruct the compressive images. You can ran `Demo.m` to gain the reconstruction image with index of PSNR and SSIM.

### **Experiments**
:---:|:---:|:---:
Dataset|BSD100|BSD100
:---:|:---:|:---:|:---:|:---:
Methods|PSNR|SSIM|PSNR|SSIM
CCN-YOLO|26.56|0.8192|26.54|0.8786
CCN-SSD|25.19|0.7872|25.46|0.8253
ADAGIO|22.42|0.6055|23.89|0.6325
RandConv|22.31|0.6243|22.21|0.6608
CS-SM|21.39|0.5954|21.46|0.6217
GAUSS|21.32|0.5921|22.48|0.6409

