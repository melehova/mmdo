function [P,F,i,c,fc] = metD2M(fun,P,F,i,a,b,e,X,D)
% Метод ділення інтервалу навпіл (Division 2)
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
% c, fc - кінцева точка пошуку
displ(' Метод ділення інтервалу навпіл')
line2sn(35)
displ('    i  L        fx         x')
line2sn(35)
c = (a + b)/2; Y = X + c*D;
fc = fun(Y); % середина інтервалу
i = i + 1; P(:,i) = Y; F(i) = fc;
L = c - a;
displ([i2s5(i) r2s10(L) r2s10(fc) v2s(Y)])
while L > e % Цикл метода
 u = (a + c)/2; Y = X + u*D; fu = fun(Y); L = c - a;
 i = i + 1; P(:,i) = Y; F(i) = fu;
 displ([i2s5(i) r2s10(L) r2s10(fu) v2s(Y)])
 if fu < fc % зміщення правого кінця інтервалу
 b = c; c = u; fc = fu;
 else
 v = (c + b)/2; Y = X + v*D; fv = fun(Y);
 i = i + 1; P(:,i) = Y; F(i) = fv;
 displ([i2s5(i) r2s10(L) r2s10(fv) v2s(Y)])
 if fv < fc % зміщення лівого кінця інтервалу
 a = c; c = v; fc = fv;
 else % зміщення інтервала у центр
 a = u; b = v;
 end
 end
end
line2sn(35)
displ(['i = ' num2str(i) ' L = ' num2str(L)])