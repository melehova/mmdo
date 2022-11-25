f = @funl4;
x0 = [-4 3];
h = 2;
E = 1e-3;
E1 = 1e-2;
N = 100;
n = length(x0);
P = zeros(n,N); F = zeros(1,N);
fx = f(x0);
delta = 0.0001;
k = 0;
i = 1; P(:,i) = x0; F(i) = fx;
ns = 1;
% E1 = E;
g = Grad1(x0, fx,f);
while ns > E 
    k = k + 1;
    d = -g;
    nd = norm(d);
    if nd > 0
        dn = d/nd;
    else
        disp('zero vector route');
        Graph3(f,P,F)
        return
    end
    [P,F,i,a,b,c,fa,fb,fc] = SwanM(f,P,F,i,x0,d);
    [P,F,i,u,fx] = metDichotomyM(f, P, F, i, a ,b,delta,E1,x0,d);
    s = u*d; x0 = x0 + s; ns = norm(s);
    disp('Метод наискорейшого спуска')
    line2sn(45);
    disp('     k     ns      fx       x1        x2')
    line2sn(45);
    disp([i2s5(k) r2s10(ns) r2s10(fx) v2s(x0)])
    line2sn(45);
    g = Grad1(x0,fx,f);
end
Graph3(f,P,F)