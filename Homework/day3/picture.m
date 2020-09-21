pic = imread('lena.jpeg');

%swith channel
%imshow([pic,pic(:,:,[3 1 2]),pic(:,:,[2 3 1])]);

%add operation
%pic_noise_gs = imnoise(pic,'gaussian',0.1);
%pic_noise_sp = imnoise(pic,'salt & pepper',0.1);
%pic_noise_lc = imnoise(pic, 'speckle');
%imshow([pic_noise_gs pic_noise_sp pic_noise_lc])

%multiply operation
%imshow([pic pic.*2 pic.*3 pic.*4])

%rotate image
%pr90 = imrotate(pic, 90);
%pr270 = imrotate(pic, 270);
%pr180 = imrotate(pic, 180);
%imshow([pic pr90 pr180 pr270])

%hist
%imhist(pic);

%fft
%y = fftshift(pic);
%h1 = [1 2 1; 0 0 0; 1 -2 -1];
%x = filter2(h1,pic(:,:,2));
%z = fft(pic(:,:,1));
%imshow(z)
