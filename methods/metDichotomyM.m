function [P,F,i,u,fu] = metDichotomyM(fun,P,F,i,a,b,d,e,X,D)
% Метод дихотомії
% Вхідні параметри:
% fun - підпрограма обчислення функції
% P - масив усіх точок пошуку
% F – масив значень функції
% i - кількість точок пошуку
% a, b - кінці інтервалу невизначеності
% d - відстань між внутрішніми точками
% e - допустима помилка
% Вихідні параметри:
% P - масив усіх точок пошуку
% F - масив значень функції
% i - кількість точок пошуку
% u, fu - кінцева точка пошуку
displ(' Метод дихотомії ')
line2sn(35)
displ('    i  L        fx         x')
line2sn(35)
while true
    c = (a + b)/2; u = c - d;
    Y = X + u*D; fu = fun(Y);
    i = i + 1; P(:,i) = Y; F(i) = fu;
    displ([i2s5(i)   r2s10(u - a)    r2s10(fu)   v2s(Y)])
    v = c + d; Y = X + v*D; fv = fun(Y);
    i = i + 1; P(:,i) = Y; F(i) = fv;
    displ([i2s5(i)   r2s10(v - a)    r2s10(fv)   v2s(Y)])
    if v - a <= e
        break
    end
    if fu < fv
        b = v;
    else
        a = u;
    end
end
line2sn(35)
displ(['i = ' num2str(i) ' L = ' num2str(v - a)])