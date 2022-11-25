function [ P, F, i, u, fu ] = AlgZolSechM( f, P, F, i, a, b, e, X,D )
disp('Метод золотого сечения')
line2sn(35)
disp('     k     ns         fx    x1        x2')
line2sn(35)
t = (sqrt(5)-1)/2;
L =  t * (b - a);
u = b - L;
Y = X + u*D;
fu = f(Y);
i = i + 1; P(:,i) = Y; F(i) = fu;
disp([i2s5(i) r2s10(L) r2s10(fu) v2s(Y)])

v = a + L; Y = X + v*D; fv = f(Y);
i = i + 1; P(:,i) = Y; F(i) = fv;
disp([i2s5(i) r2s10(L) r2s10(fv) v2s(Y)])

while L > e
    if fu < fv
        b = v; v = u; fv = fu;
        L = u - a;
        u = b - L; Y = X + u*D; fu = f(Y);
        i = i + 1;
        P(:,i) = Y;
        F(i) = fu;
        disp([i2s5(i) r2s10(L) r2s10(fu) v2s(Y)])
        
    else
        a = u; u = v;  fu = fv;
        L = b - v;  v = a + L;
        Y = X + v*D;
        fv = f(Y);
        i = i + 1;
        P(:,i) = Y;
        F(i) = fv;
        disp([i2s5(i) r2s10(L) r2s10(fv) v2s(Y)])
    end
end
line2sn(35);
end