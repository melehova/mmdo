fun = @funl6;
X = [-4 3]; h = 2; E = 1e-3; E1 = 1e-2; N = 100; delta = 0.001;
n = length(X); P = zeros(n,N); F = zeros(1,N);
fx = fun(X);
i = 1; P(:,i) = X; F(i) = fx;
[P,F,i,x,fx] = metNewton(fun,P,F,i,X,E,delta,E1,h,'metI3p4M');

