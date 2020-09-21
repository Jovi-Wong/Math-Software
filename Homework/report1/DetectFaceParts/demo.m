img = imread('data/heying.jpg');

detector = buildDetector();
[bbox, bbimg, ~, bbfaces] = detectFaceParts(detector,img,2);

figure;imshow(uint8(bbimg));
for i=1:size(bbfaces,1)
    figure;imshow(uint8(bbfaces{i}));
end

% Please uncoment to run demonstration of detectRotFaceParts

%  img = imrotate(img,180);
%  detector = buildDetector(2,2);
%  [fp, bbimg, faces, bbfaces] = detectRotFaceParts(detector,img,15,2);
% 
%  figure;imshow(bbimg);
%  for i=1:size(bbfaces,1)
%     figure;imshow(bbfaces{i});
%  end
