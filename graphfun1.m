function graphfun1(fun,X,F)
% Побудова графіка функції однієї змінної
% і траекторії пошука
% Вхідні параметри:
% fun - підпрограма обчислення функції
% Х - масив точок пошуку
% F - масив значень функції
n = 100; n1 = n + 1; % число точок графіка
% Межі інтервалу графіка:
a = min(X); b = max(X); N = length(F);
h = (b-a)/n; % корк побудови графіка
Xg = zeros(1,n1); Fg = Xg; x = a;
% Цикл обчислення точок графіка:
for i = 1:n1
 Xg(i) = x; Fg(i) = fun(x); x = x + h;
end
% Побудова одновимірного графіка
figure(1), cla reset % Вікно одновимірного графіка
set(gcf,'Position',[5 300 700 450],'Color','w')
% Відображення одновимірного графіка функції
plot(Xg,Fg,'b','LineWidth',1)
hold on, grid on
% Відображення траекторії пошуку
plot(X,F,'ro-','LineWidth',2,...
'MarkerSize',6,'MarkerFaceColor','y')
% Відображення початкової точки пошуку
plot(X(1),F(1),'ro','LineWidth',2,...
'MarkerSize',12,'MarkerFaceColor','g')
% Відображення кінцевої точки пошуку
plot(X(N),F(N),'rd','LineWidth',2,...
'MarkerSize',12,'MarkerFaceColor','y')
xlabel('\itx'), ylabel('\itf','Rotation',0)
% Побудова багатовимірного графіка
figure(2), cla reset % Вікно тривимірного графіка
set(gcf,'Position',[700 300 700 450],'Color','w')
% Дані тривимірного графіка
I = 1:N; [II,XX] = meshgrid(I,Xg);
FF = repmat(Fg',1,N);
% ідображення кінцевої точки пошуку
plot3(X(N),N,F(N),'rd','LineWidth',2,...
'MarkerSize',12,'MarkerFaceColor','y')
hold on, grid on, box on
% Відобраення одновимірних графіків функції
plot3(XX,II,FF,'b','LineWidth',1)
% Відображення траекторії пошуку
plot3(X,I,F,'ro-','LineWidth',2,...
'MarkerSize',6,'MarkerFaceColor','y')
% Відображення початкової точки пошуку
plot3(X(1),1,F(1),'ro','LineWidth',2,...
'MarkerSize',12,'MarkerFaceColor','g')
axis([a,b,1,N]) % масштабування вісей
xlabel('\itx'), ylabel('\iti')
zlabel('\itf','Rotation',0)
rotate3d on