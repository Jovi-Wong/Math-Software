%picture infomation
I = imread('flood.png');
white = double(I(526, 99,:));
m = 616;
n = 794;
mask = zeros(m,n);
pic = zeros(m,n,3); 
%exist for asist formulate mask

for i=1:m
    for j=1:n
        for k = 1:3
            pic(i,j,k) = double(I(i,j,k));
        end
        %select white
        if dist3(pic(i,j,:),white) < 50
            if i>500
                mask(i,j) = 1;
            end
        end
        
        %select red
        if pic(i,j,1) > 200
            if pic(i,j,2) <150
               mask(i,j) = 1;
            end
        end
    end
end
%here we initialize the mask successfully

%convert rgb I into gray double img
% I = rgb2gray(I);
%imshow(I)

img = zeros(m,n);
for i = 1:m
    for j =1:n
        if mask(i,j) == 0
            img(i,j) = pic(i,j);
        else
            img(i,j) = 0;
        end
    end
end
imshow(uint8(img))
% %neutral network to transformimg
% lambda = 100;
% a = 100;
% imgn = img;
% 
% for t = 1:2000
%     %a = psnr(I,uint8(img));
%     %fprintf('Round %d and snr = %d \n',t,a);
%     for i = 1:m
%         for j = 1:n
%             if mask(i,j)==1
%                 Un=sqrt((img(i,j)-img(i-1,j))^2 + ((img(i-1,j-1)-img(i-1,j+1))/2)^2);
%                 Ue=sqrt((img(i,j)-img(i,j+1))^2 + ((img(i-1,j+1)-img(i+1,j+1))/2)^2);
%                 Uw=sqrt((img(i,j)-img(i,j-1))^2 + ((img(i-1,j-1)-img(i+1,j-1))/2)^2);
%                 Us=sqrt((img(i,j)-img(i+1,j))^2 + ((img(i+1,j-1)-img(i+1,j+1))/2)^2);
%                 
%                 Wn=1/sqrt(Un^2+a^2);
%                 We=1/sqrt(Ue^2+a^2);
%                 Ww=1/sqrt(Uw^2+a^2);
%                 Ws=1/sqrt(Us^2+a^2);
% 
%                 Hon=Wn/((Wn+We+Ww+Ws)+lambda);
%                 Hoe=We/((Wn+We+Ww+Ws)+lambda);
%                 How=Ww/((Wn+We+Ww+Ws)+lambda);
%                 Hos=Ws/((Wn+We+Ww+Ws)+lambda);
% 
%                 Hoo = lambda/((Wn+We+Ww+Ws) + lambda);
%                 imgn(i,j) = Hon*img(i-1,j) + Hoe*img(i,j+1) + How*img(i,j-1) + Hos*img(i+1,j) + Hoo*img(i,j);
%             end
%         end
%     end
%     img = imgn;
% end
% 
% %convert double img to uint8 result 
% result = uint8(zeros(m,n));
% for i = 1:m
%     for j = 1:n
%         result(i,j) = img(i,j);
%     end
% end
% 
% imshow(result)

 function d = dist3(x,y)
    d = sqrt((x(1)-y(1))^2+(x(2)-y(2))^2+(x(3)-y(3))^2);
 end