% Сценарій тестування обчислення функції
fun = @fun00Lab02; % підпрограма цільової функції
x0 = -3; f0 = fun(x0); % початкова точка
disp(['x0 = ' num2str(x0) ' f0 = ' num2str(f0)])
df0 = der1(fun,x0,f0);
disp(['df0 = ' num2str(df0)])
xo = 0; fo = fun(xo); % оптимальна точка
disp(['xo = ' num2str(xo) ' fo = ' num2str(fo)])
[dfo,d2fo] = der2(fun,xo,fo);
disp(['dfo = ' num2str(dfo) ' d2fo = ' num2str(d2fo)])