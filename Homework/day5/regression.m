example = [144 39 24.2;
           162 64 28.0;
           136 36 25.0;
           215 47 31.1;
           150 56 25.8;
           142 50 26.2;
           138 45 22.6;
           140 59 27.3;
           120 39 23.5;
           145 47 24.0;
           110 34 20.1;
           120 21 20.3;
           162 65 25.9;
           128 42 21.7;
           160 44 27.1;
           142 46 25.1;
           130 48 22.2;
           158 53 28.6;
           170 67 29.5;
           135 45 27.4;
           144 63 28.3;
           124 42 19.7;
           114 18 18.8;
           130 29 22.0;
           158 67 27.2;
           116 20 22.6;
           125 25 25.3;
           154 56 19.3;
           124 19 21.5;
           175 69 27.4];
    
cig = [0;1;0; 1; 0; 1; 0; 0; 0; 1; 0; 0; 1; 0; 1; 0; 1; 1; 1; 0; 0; 0; 0; 1; 1; 0; 0; 0; 0; 1];
blood = example(:,1);
age = example(:,2);
weight = example(:,3);
X = [ones(30,1) age weight cig];
x = 10:1:70;
[b, bint, r, rint, stats] = regress(blood, X);
% scatter3(age, weight, cig,'filled');
% hold on
% x1fit = min(age):1:max(age);
% x2fit = min(weight):0.1:max(weight);
% [X1FIT, X2FIT] = meshgrid(x1fit, x2fit);
% YFIT = b(1)+b(2)*age+b(3)*weight+b(4)*cig;
% mesh(X1FIT,X2FIT,YFIT)
% hold off
% hold on
% plot(x, b(2)*x+b(1));
% xlabel('age');
% ylabel('blood pressure');
% figure
% hold off

% rcoplot(r,rint);
% xlabel('example set');
% ylabel('residual');
% figure

