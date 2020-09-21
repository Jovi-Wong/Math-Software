I=imread('lena.jpg');
figure;subplot(5,3,1)
imshow(I)
title('original figure')
I=double(I)/255;
for i=1:14
    F = imkmeans(I,i);
    subplot(5,3,i+1);
    imshow(F,[]);
    title(['K = ',num2str(i)])
end
print -dpng lena-clustering.png


function [F,C] = imkmeans(I,C)
    if nargin~=2
        error('只能有两个输入参数');
    end
    if isempty(C)
        K=2;
        C=[];
    elseif isscalar(C)
        K=C;
        C=[];
    else
        K=size(C,1);
    end
    X = exactvecotr(I);
    if isempty(C)
        C = searchintial(X,'sample',K);
    end
    Cprev=rand(size(C));
    while true
        D = sampledist(X,C,'euclidean');
        [~,locs]=min(D,[],2);
        for i=1:K
            C(i,:)=mean(X(locs==i,:),1);
        end
        if norm(C(:)-Cprev(:))<eps
            break
        end
        Cprev=C;
    end
    [m,n,~]=size(I);
    F=reshape(locs,[m,n]);
end

function vec = exactvecotr(img)
    [m,n,~] = size(img);
    vec=zeros(m*n,3);
    img=double(img);
    for j=1:n
        for i=1:m
            color=img(i,j,:);
            wx=1;wy=1;
            dist=[wx*j/n,wy*i/m];
            dist=[];
            texture=[];
            vec((j-1)*m+i,:)=[color(:);dist(:);texture(:)];
        end
    end
end

function C = searchintial(X,method,varargin)
    switch lower(method(1))
        case 's'
            K=varargin{1};
            C=X(randsample(size(X,1),K),:);
        case 'u'
            Xmins=min(X,[],1);
            Xmaxs=max(X,[],1);
            K=varargin{1};
            C=unifrnd(Xmins(ones(K,1),:),Xmaxs(ones(K,1),:));
    end
end

function D=sampledist(X,C,method,varargin)
    [n,p]=size(X);
    K=size(C,1);
    D=zeros(n,K);
    switch lower(method(1))
        case 'e'
            for i =1:K
                D(:,i)=(X(:,1)-C(i,1)).^2;
               for j=2:p
                    D(:,i)=D(:,i)+(X(:,j)-C(i,j)).^2;
               end
            end
        case 'c'
            for i=1:K
                D(:,i)=abs(X(:,1)-C(i,1));
                for j=2:p
                    D(:,i)=D(:,i)+abs(X(:,j)-C(i,j));
                end
            end
    end
end