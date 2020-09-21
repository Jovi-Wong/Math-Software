load carsmallm; 
tempx1 = Weight; tempx2 = Horsepower; tempy = MPG;
x1 = [];
x2 = [];
y = [];
for i = 1:100
    if i ~= 26 && i ~= 52 && i ~= 90 && i ~= 97
        x1 = [x1 tempx1(i)];
        x2 = [x2 tempx2(i)];
        y = [y tempy(i)];
    end
end
 x1 = x1';
 x2 = x2';
 y = y';
x = [ones(size(x1)) x1 x2 x1.*x2];
[b, bint, r, rint, stats] = regress(y, x);
scatter3(x1,x2,y,'filled'); axis tight
[xx,yy] = meshgrid(min(x1):100:max(x1), min(x2):10:max(x2));
zz = b(1) + b(2)*xx + b(3)*yy + b(4)*xx.*yy;
mesh(xx,yy,zz); view(50,10);

xlabel('Weight'); ylabel('Horsepower'); zlabel('MPG');
hold on; scatter3(x1,x2,y,'filled'); hold off;

figure; rcoplot(r, rint);