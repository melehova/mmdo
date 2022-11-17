% Тестування метода золотого перетину
fun = @fun00Lab02; % підпрограма цільової функції
x0 = -3; % початкова точка
xo = 3; % отпимальна точка
h = 3; % початковий крок
e = 1e-2; % допустима похибка
N = 100; % межова кількість точок
% Виклик метода Свена
[P,F,i,a,b] = metSvenn(fun,x0,h,N);
% Виклик метода золотого перетину
[P,F,i,x,fx] = metGoldenSection(fun,P,F,i,a,b,e);
P(i+1:N) = []; F(i+1:N) = [];
disp(['fx = ' num2str(fx) ' x = ' num2str(x)])
[dfx,d2fx] = der2(fun,x,fx);
disp(['dfx = ' num2str(dfx) ' d2fx = ' num2str(d2fx)])
% побудова графіка процесу
graphfun1(fun,P,F)

