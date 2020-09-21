n = 100000000;
x = rand(2,n);
k = 0; tic;
for i = 1:n
        if(x(1,i)^2 + x(2,i)^2 <= 1)
                k = k + 1;
        end
end
toc; p = 4*k/n