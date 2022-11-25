fun = @funl4;
X = [-4 3]; h = 2; E = 1e-3; E1 = 1e-2; N = 100;
n = length(X); P = zeros(n,N); F = zeros(1,N);
fx = fun(X);
k = 0; i = 1; P(:,i) = X; F(i) = fx;
fx = fun(X); gx = Grad1(X,fx,fun); d = -gx;
while true
    k = k + 1;
    [P,F,i,u,fx] = argminM('metStepAdaptationM',fun,P,F,i,0,E1,h,X,d);
    s = u*d; X = X + s; ns = norm(s);
    gy = gx;
    gx = Grad1(X,fx,fun);
    B = (gx.'*gx)./(gy.'*gy); % FletcherReeves
    B = gx.'*(gx-gy)./(gy.'*gy); % PolackRibier
    d = -gx+B(2,2)*d;
    displ("Метод Полака-Рів'єра (Метод Флетчера-Рівса)")
    line2sn(45);
    displ('     k     ns      fx       x1        x2')
    line2sn(45);
    displ([i2s5(k) r2s10(ns) r2s10(fx) v2s(X)])
    line2sn(45);
    if (abs(s) <= E)
        break;
    end
end