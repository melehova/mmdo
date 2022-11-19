function [P,F,i,x,fx] = metGoldenSectionM(fun,P,F,i,a,b,e,X,D)
% Метод золотого перетину
% Вхідні параметри:
% fun - підпрограма обчислення функції
% P - масив усіх точок пошуку
% F – масив значень функції
% i - кількість точок пошуку
% a, b - кінці інтервалу невизначеності
% e - допустима помилка
% Вихідні параметри:
% P - масив усіх точок пошуку
% F - масив значень функції
% i - кількість точок пошуку
% x, fx - кінцева точка пошуку
displ(' Метод золотого перетину')
line2sn(35)
displ('    i  L        fx         x')
line2sn(35)
t = 0.5 * (sqrt(5) - 1);
h = t * (b - a);
x = b - h;
Y = X + x*D;
fx = fun(Y);
i = i + 1; P(:,i) = Y; F(i) = fx;
displ([i2s5(i)   r2s10(b - a)    r2s10(fx)   v2s(Y)])
y = a + h;
Y = X + y*D;
fy = fun(Y);
i = i + 1; P(:,i) = Y; F(i) = fy;
displ([i2s5(i)   r2s10(b - a)    r2s10(fy)   v2s(Y)])
while true
    if (fx > fy)
        a = x;
        x = y;
        fx = fy;
        d = b - a;
        y = a + t *d;
        Y = X + y*D;
        fy = fun(Y);
        i = i + 1; P(:,i) = y; F(i) = fy;
        displ([i2s5(i)   r2s10(b - a)    r2s10(fy)   v2s(Y)])
    else
        b = y;
        y = x;
        fy = fx;
        d = b - a;
        x = b - t * d;
        Y = X + x*D;
        fx = fun(Y);
        i = i + 1; P(:,i) = Y; F(i) = fx;
        displ([i2s5(i)   r2s10(b - a)    r2s10(fx)   v2s(Y)])
    end
    if (d <= e)
        break
    end
end
if (fy < fx)
    x = y;
    fx = fy;
end
line2sn(35)
displ(['i = ' num2str(i) ' L = ' num2str(d)])