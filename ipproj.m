I=imread('C:\Users\jahnavi reddy\matlabsem4pro\Brain-Tumor-Detection-using-Image-Processing\3.jpg');
figure, imshow(I); title('Brain MRI Image');
I = imresize(I,[200,200]);
I= rgb2gray(I);%Converting mri to grey scale
I= im2bw(I,.6);%converting into binary image with thresold 0.6
figure, imshow(I);title('Thresholded Image');
%Applying gradient
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
%figure, imshow(gradmag), title('gradient magnitude ')
L = watershed(gradmag);%watershed transform of gradient magnitude
Lrgb = label2rgb(L);
figure, imshow(Lrgb), title('Watershed segmented image ')
%Marking of foreground objects
%morphological techniques called "opening-by-reconstruction" and "closing-by-reconstruction" to "clean" up the image.
se = strel('disk', 20);% creates a disk-shaped structuring element,
Io = imopen(I, se);
%figure, imshow(Io), title('Opening')
Ie = imerode(I, se);% compute the opening-by-reconstruction using imerode and imreconstruct.
Iobr = imreconstruct(Ie, I);
%figure, imshow(Iobr), title('Opening by reconstruction')
Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
%figure, imshow(Iobr), title('Opening-closing  by reconstruction')
I2 = I;
fgm = imregionalmax(Iobrcbr);%Regional Maxima of Opening-Closing by Reconstruction
bw = im2bw(Iobrcbr);%Thresholded Opening-Closing by Reconstruction'
figure
imshow(bw), title('only tumor')
 