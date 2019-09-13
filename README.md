# deconv1D
Matlab codes for solving the inverse problem of deconvolution. This set of codes deals with one-dimensional signals. The original codes that served as a atarting point of this repository have been developed by Professor Samuli Siltanen during years 2006-2019 related to his inverse problems courses given at Tampere University of Technology and at University of Helsinki.

The set of codes works roughly like this. First a simulated convolution-deconvolution example is created, followed by a demonstration of how naive inversion fails. Naive inversion means here applying the inverse of the system matrix to the data vector. Note that "inverse crime" is avoided in the creation of the simulated data.

Next, various regularized reconstruction methods are implemented and tested on the simulated data. These include truncated singular value decomposition (TSVD), Tikhonov regularization in classical and generalized form, Total Variation (TV) regularization, and wavelet sparsity reconstruction. 

Finally, Convolutional Neural Networks (CNN) are applied to the deconvolution problem. 
