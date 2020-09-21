function [x,iter]=newton(x0,tol,maxit)

iter = 0;
err = 1;
x = x0;
while(err > tol && iter < maxit)
    x0 = x;
    x = x0 - df(x0)\f(x0);
    err = norm(x - x0);
    iter = iter + 1;
    fprintf('iter %d: x = %f, f(x) = %f\n', iter, x, f(x));
end

if norm(x - x0)<= tol
%    disp(['x = ',x]);
    disp('the toleare reached.\n');
end

if iter >= maxit
    disp('the max iter number is reached');
end
end

function y = f(x)
 y = 3*x^2 - exp(x);
end

function y = df(x)
    y = 6*x - exp(x);
end
        