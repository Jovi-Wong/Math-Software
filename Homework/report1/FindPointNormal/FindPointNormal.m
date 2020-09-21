%  Required Inputs:
%   points- nx3 set of 3d points (x,y,z)
%  Optional Inputs: (will give default values on empty array [])
%  Outputs:
%   normals- nx3 set of normals (nx,ny,nz)
%   curvature- nx1 set giving the curvature

function [ normals, curvature ] = FindPointNormal(points, numNeighbours, viewPoint, ~)
%ensure inputs of correct type
points = double(points);
viewPoint = double(viewPoint);
%create kdtree
kdtreeobj = KDTreeSearcher(points,'distance','euclidean');
%get nearest neighbours
n = knnsearch(kdtreeobj,points,'k',(numNeighbours+1));
%remove self
n = n(:,2:end);
%find difference in position from neighbouring points
p = repmat(points(:,1:3),numNeighbours,1) - points(n(:),1:3);
p = reshape(p, size(points,1),numNeighbours,3);
%calculate values for covariance matrix
C = zeros(size(points,1),6);
C(:,1) = sum(p(:,:,1).*p(:,:,1),2);
C(:,2) = sum(p(:,:,1).*p(:,:,2),2);
C(:,3) = sum(p(:,:,1).*p(:,:,3),2);
C(:,4) = sum(p(:,:,2).*p(:,:,2),2);
C(:,5) = sum(p(:,:,2).*p(:,:,3),2);
C(:,6) = sum(p(:,:,3).*p(:,:,3),2);
C = C ./ numNeighbours;
% normals and curvature calculation
normals = zeros(size(points));
curvature = zeros(size(points,1),1);
for i = 1:(size(points,1))
    %form covariance matrix
    Cmat = [C(i,1) C(i,2) C(i,3);...
        C(i,2) C(i,4) C(i,5);...
        C(i,3) C(i,5) C(i,6)];  
    %get eigen values and vectors
    [v,d] = eig(Cmat);
    d = diag(d);
    [lambda,k] = min(d);
    %store normals
    normals(i,:) = v(:,k)';
    %store curvature
    curvature(i) = lambda / sum(d);
end

% flipping normals
points = points-repmat(viewPoint,
                size(points,1),1);
if(dirLagest)
    [~,idx] = max(abs(normals),[],2);
    idx = (1:size(normals,1))'+
         (idx-1)*size(normals,1);
    dir = normals(idx).*points(idx)>0;
else
    dir = sum(normals.*points,2)>0;
end
normals(dir,:) = -normals(dir,:);
end