function [P,F,i,x,fx] = metGoldenSection(fun,P,F,i,a,b,e)
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
displ('      i       L       fx      x')
line2sn(35)
t = 0.5 * (sqrt(5) - 1);
h = t * (b - a);
x = b - h;
fx = fun(x);
i = i + 1; P(i) = x; F(i) = fx;
displ([i2s5(i)   r2s10(b - a)    r2s10(fx)   r2s10(x)])
y = a + h;
fy = fun(y);
i = i + 1; P(i) = y; F(i) = fy;
displ([i2s5(i)   r2s10(b - a)    r2s10(fy)   r2s10(y)])
while true
    if (fx > fy)
        a = x;
        x = y;
        fx = fy;
        d = b - a;
        y = a + t *d;
        fy = fun(y);
        i = i + 1; P(i) = y; F(i) = fy;
        displ([i2s5(i)   r2s10(b - a)    r2s10(fy)   r2s10(y)])
    else
        b = y;
        y = x;
        fy = fx;
        d = b - a;
        x = b - t * d;
        fx = fun(x);
        i = i + 1; P(i) = x; F(i) = fx;
        displ([i2s5(i)   r2s10(b - a)    r2s10(fx)   r2s10(x)])
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