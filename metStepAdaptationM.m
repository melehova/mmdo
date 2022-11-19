function [P,F,i,x,fx] = metStepAdaptationM(fun,P,F,i,h,e,X,D)
% Метод адаптації кроку
% Вхідні параметри:
% fun - підпрограма обчислення функції
% x - початкова точка пошуку
% h - початковий крок
% e - допустима помилка
% Вихідні параметри:
% P - масив усіх точок пошуку
% F - масив значень функції
% i - кількість точок пошуку
% x, fx - кінцева точка пошуку
displ(' Метод адаптації кроку')
line2sn(35)
displ('    i  L        fx         x')
line2sn(35)
r = 0;
x = h;
Y = X + x*D;
fx = fun(Y);
i = i + 1; P(:,i) = Y; F(i) = fx;
displ([i2s5(i) r2s10(h) r2s10(fx) v2s(Y)])
while true
    y = x + h;
    Y = X + y*D;
    fy = fun(Y);
    i = i + 1; P(:,i) = Y; F(i) = fy;
    displ([i2s5(i) r2s10(h) r2s10(fy) v2s(Y)])
    if (fy >= fx)
        if (r == 2)
            r = 0.25;
        else
            r = -0.5;
        end
    else
        x = y;
        fx = fy;
        if (r >= 0.5)
            r = 2;
        else 
            r = 0.5;
        end
    end
    h = h * r;
    if (abs(h) <= e)
        break
    end
end
line2sn(35)
displ(['i = ' num2str(i) ' L = ' num2str(abs(h))])