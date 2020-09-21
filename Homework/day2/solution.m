[x,y,z] = cylinder(1,50);
surf(x,y,z);
axis square;
hold on
[x1,y1,z1] = cylinder(1,50);
z1 = z1 - 0.5;
%x1 = x1 + 0.7;
y1 = y1 +0.5;
surf(z1,x1,y1);
hold off