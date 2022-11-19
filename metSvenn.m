function [P,F,i,a,b,c,fa,fb,fc] = ...
 metSvenn(fun,c,h,N)
% Пошук інтервала невизначенності методом Свена
% Вхідні параметри:
% fun - підпрграма обчислення функції
% c - початкова точка
% h - початковий крок пошуку
% N - межова кількість точок
% Вихідні параметри:
% P - масив всіх точок пошуку
% F - масив значень функції
% i - число точок пошуку
% a, fa - ліва точка інтервала
% b, fb - права точка інтервала
% c, fc - внутрішня точка інтервала
displ('  Метод Свена')
line2sn(35)
displ('    i  L        fx         x')
line2sn(35)
P = zeros(1,N);
F = P;
fc = fun(c);
i = 1; P(i) = c; F(i) = fc;
displ([i2s5(i) r2s10(h) r2s10(fc) r2s10(c)])
b = c + h; fb = fun(b); % Крок у прямому напрямку
i = i + 1; P(i) = b; F(i) = fb;
displ([i2s5(i)   r2s10(h)    r2s10(fb)   r2s10(b)])
if fb < fc % Перевірка прямого напрямку
 while fb < fc % Пошук у прямому напрямку
 a = c; fa = fc; c = b; fc = fb;
 h = h + h; b = c + h; fb = fun(b);
 i = i + 1; P(i) = b; F(i) = fb;
 displ([i2s5(i)  r2s10(h)    r2s10(fb)   r2s10(b)])
 end
else % Зміна напрямку пошуку
 h = -h; a = c + h; fa = fun(a);
 i = i + 1; P(i) = a; F(i) = fa;
 displ([i2s5(i)  r2s10(h)    r2s10(fa)   r2s10(a)])
 while fa < fc % Пошук у зворотньому напрямку
 b = c; fb = fc; c = a; fc = fa;
 h = h + h; a = c + h; fa = fun(a);
 i = i + 1; P(i) = a; F(i) = fa;
 displ([i2s5(i)  r2s10(h)    r2s10(fa)   r2s10(a)])
 end
end
if a > b
 d = a; fd = fa; a = b; fa = fb; b = d; fb = fd;
end
line2sn(35)
displ(['i = ' num2str(i) ' h = ' num2str(h)])
displ(['fa = ' num2str(fa) ' a = ' num2str(a)])
displ(['fb = ' num2str(fb) ' b = ' num2str(b)])
displ(['fc = ' num2str(fc) ' c = ' num2str(c)])

