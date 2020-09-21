t = -2:0.002:2;
[x,y] = meshgrid(t);
z0 = x + 1i*y;
z1 = z0 +z0.^3+2*z0.^2;
k = 1;
err = abs(z1-z0);
while k < 100 %&& norm(err,1) > 0.0000001
    z0 = z1;
    z1 = z0 +z0.^3+2*z0.^2;
    %err = abs(z1-z0);
    k = k + 1;
end
idx1 = find(abs(z1-1)<0.01);
idx2 = find(abs(z1-1i)<0.01);
idx3 = find(abs(z1+1)<0.01);
idx4 = find(abs(z1+1i)<0.01);
 
[m,n] = size(x);
flag = zeros(m,n);
flag(idx1) = 1;
flag(idx2) = 2;
flag(idx3) = 3;
flag(idx4) = 4;
 
imagesc(flag);
                    