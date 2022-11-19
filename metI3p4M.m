function [P,F,i,z,fz] = metI3p4M(fun,P,F,i,a,b,u,fa,fb,fu,e,X,D)
% Метод кубічної інтерполяції з 4 точками
% Вхідні параметри:
% fun - підпрограма обчислення функції
% P - масив усіх точок пошуку
% F - масив значень функції
% i - число точок пошуку
% a, b - кінці інтервала невизначеності
% u - внутрішня точка інтервала
% fa, fb - значення функції у кінцях інтервала
% fu - Значення функції у внутрішній точці
% e - припустима похибка
% Вихідні параметри:
% % P - масив усіх точок пошуку
% F - масив значень функції
% i - число точок пошуку
% x, fx - кінцева точка пошуку
% Выходные параметры:
% P - массив всех точек поиска
% F - массив значений функции
% i - число точек поиска
% z, fz - конечная точка поиска
displ('Метод кубічної інтерполяції з 4 точками')
line2sn(35)
displ('    i  L        fx         x')
line2sn(35)
p = (u - a)*(fb - fu); q = (b - u)*(fa - fu);
s = p + q;
v = 0.5*(p*(a + u) + q*(b + u))/s; h = v - u;
Y = X + v*D;
fv = fun(Y); i = i + 1; P(:,i) = Y; F(i) = fv;
z = v; fz = fv;
displ([i2s5(i) r2s10(h) r2s10(fv) v2s(Y)])
% точки u і v розташовуються у порядку зростання 
if v < u
    c = u; fc = fu; u = v; fu = fv; v = c; fv = fc;
end 
% w = v; fw = fv;
while abs(h) > e % Цикл метода
    dua = u - a; dva = v - a;
    dba = b - a; dvu = v - u;
    dbu = b - u; dbv = b - v;
    sau = a + u; svb = v + b;
    rau = a*u; rvb = v*b;
    pa = fa*dvu*dbu*dbv; pu = fu*dva*dba*dbv;
    pv = fv*dua*dba*dbu; pb = fb*dua*dva*dvu;
    Da = pu - pa - pv + pb;
    Db = pa*(u + svb) - pu*(a + svb) + ...
    pv*(sau + b) - pb*(sau + v);
    Dg = pu*(svb*a + rvb) - pa*(svb*u + rvb) - pv*(rau + sau*b) + pb*(rau + sau*v);
    w = -Dg/(sqrt(Db*Db - 3*Da*Dg) + Db);
    Y = X + w*D; fw = fun(Y); h = w - z; 
    i = i + 1; P(:,i) = Y; F(i) = fw;
    z = w; fz = fw;
    displ([i2s5(i)  r2s10(h) r2s10(fw) v2s(Y)])
    % Точки u, v, w у порядку зростання
    if w < u
        c = u; fc = fu; u = w; fu = fw;
        w = c; fw = fc;
    end
    if w < v
        c = v; fc = fv; v = w; fv = fw;
        w = c; fw = fc;
    end
    if fu < fw % точка u лучше чем w
        b = w; fb = fw;
    else % точка w лучше чем u
        a = u; fa = fu; u = v; fu = fv;
        v = w; fv = fw; 
    end
end
line2sn(35)
displ(['i = ' num2str(i) ' h = ' num2str(h)])
