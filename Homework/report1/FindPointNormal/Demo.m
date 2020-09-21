%generate a set of 3d points
x = repmat(1:49,49,1);
y = x';
z = 10*sin(x./5)+5*cos(y./7)+sin(x).*cos(y);
points = [x(:),y(:),z(:)];

%find the normals and curvature
[normals,curvature] = FindPointNormal(points,5,[0,0,10],true);

%plot normals and colour the surface by the curvature

surf(x,y,z,reshape(curvature,49,49))
hold on;
quiver3(points(:,1),points(:,2),points(:,3),...
    normals(:,1),normals(:,2),normals(:,3),'y');
xlabel x;
ylabel y;
zlabel z;
axis equal;