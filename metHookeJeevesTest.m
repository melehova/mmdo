fun = @funl7;
X = [100 10]; h = 2; E = 1e-3; E1 = 1e-2; N = 100; delta = 0.001;
n = length(X); P = zeros(n,N); F = zeros(1,N);
fx = fun(X); i = 0;
[P,F,i,x,fx] = metHookeJeeves(fun,P,F,i,X,E,h);
Graph3(fun,P,F)
% P(:,i) = x; F(i) = fx;