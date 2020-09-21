I = imread('flood.png');
%red = double(I(90,50,:));
white = double(I(526, 99,:));

%Ig = imnoise(I,'gaussian',0.1);
%I = rgb2gray(I);
%Ig = rgb2gray(Ig);
%psnr(I, Ig)
%In = Ig;
%H = fspecial('gaussian',3,0.5);
%snr = [];

m = 616;
n = 794;
mask = zeros(m,n);
pic = zeros(m,n,3);

for i=1:m
    for j=1:n
        for k = 1:3
            pic(i,j,k) = double(I(i,j,k));
        end
        
        if dist3(pic(i,j,:),white) < 50
            if i>300
                mask(i,j) = 1;
            end
        end
        
        if pic(i,j,1) > 200
            if pic(i,j,2) <150
                mask(i,j) = 1;
            end
        end
    end
end

pic = rgb2gray(uint8(pic));
img = zeros(m,n);

for i = 1:m
    for j =1:n
        img(i,j) = double(pic(i,j));
    end
end

lambda = 0.2;
a = 0.5;
imgn = img;
iter = 0;

for t = 1:10
    fprintf('Round %d ... \n',t);
    for i = 2:m-1
        for j = 2:n-1
            if mask(i,j)==1
                Un=sqrt((img(i,j)-img(i-1,j))^2 + ((img(i-1,j-1)-img(i-1,j+1))/2)^2);
                Ue=sqrt((img(i,j)-img(i,j+1))^2 + ((img(i-1,j+1)-img(i+1,j+1))/2)^2);
                Uw=sqrt((img(i,j)-img(i,j-1))^2 + ((img(i-1,j-1)-img(i+1,j-1))/2)^2);
                Us=sqrt((img(i,j)-img(i+1,j))^2 + ((img(i+1,j-1)-img(i+1,j+1))/2)^2);
                
                Wn=1/sqrt(Un^2+a^2);
                We=1/sqrt(Ue^2+a^2);
                Ww=1/sqrt(Uw^2+a^2);
                Ws=1/sqrt(Us^2+a^2);

                Hon=Wn/((Wn+We+Ww+Ws)+lambda);
                Hoe=We/((Wn+We+Ww+Ws)+lambda);
                How=Ww/((Wn+We+Ww+Ws)+lambda);
                Hos=Ws/((Wn+We+Ww+Ws)+lambda);

                Hoo = lambda/((Wn+We+Ww+Ws) + lambda);
                imgn(i,j) = Hon*img(i-1,j) + Hoe*img(i,j+1) + How*img(i,j-1) + Hos*img(i+1,j) + Hoo*img(i,j);
            end
        end
    end
    img = imgn;
end

result = uint8(zeros(m,n));

for i = 1:m
    for j = 1:n
        result(i,j) = uint8(img(i,j));
    end
end

imshow(result)

% for i=1:m
%     for j=1:n
%         for k = 1:3
%             I(i,j,k) = uint8(img(i,j,k));
%         end
%     end
% end




 function d = dist3(x,y)
    d = sqrt((x(1)-y(1))^2+(x(2)-y(2))^2+(x(3)-y(3))^2);
 end