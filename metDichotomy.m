function [P,F,i,u,fu] = metDichotomy(fun,P,F,i,a,b,d,e)
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
displ('      i       L       fx      x')
line2sn(35)
while true
    c = (a + b)/2; % середина інтервалу
    u = c - d;
    fu = fun(u);
    v = c + d;
    fv = fun(v);
    i = i + 1; P(i) = u; F(i) = fu;
    displ([i2s5(i)   r2s10(u - a)    r2s10(fu)   r2s10(u)])
    i = i + 1; P(i) = v; F(i) = fv;
    displ([i2s5(i)   r2s10(v - a)    r2s10(fv)   r2s10(v)])
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