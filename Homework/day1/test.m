%Package symbolic
syms x
root = solve(x+3 == 3*x)

%Matrix Multiply
a = [1 2 3]
b = [3 2 1];
vm = a'*b;

%Vector Product
ip = dot(a,b)
op = cross(a,b);

%Initialize Matrix
A = rand(5,5)
B = A(2:3, 1:2)
I = ones(4,4)
O = zeros(2,2)

%Newton Iteration

iter = 0;
err = 1;
x0 = 2.0;
x = x0;
format long;
while(err > 1e-8 && iter < 20)
x0 = x;
x = x0 - df(x0)\f(x0);
err = norm(x - x0);
iter = iter +1;
fprintf('iter %d: x = %18.15f, f(x) = %28.15f \n', iter, x, f(x))
end

%Define Function and Plot
t = linspace(0,20,40);
plot(t, besselj(0.5, t), 'r*-')
hold on
plot(t,besselj(1.5, t), 'b*--')
plot(t,besselj(5.5,t), 'cs-')
plot(t, besselj(10.5,t), 'mo--')
hold off

function y = my_func(x)
y = 3*x.^2 + 2*x + 18;
end

function y = df(x)
    y = 6*x -exp(x);
end

function y = f(x)
    y = 3*x^2 - exp(x);
end
    