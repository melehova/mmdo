function line2sn(n)
% Відображення лінії довжиною n символів
% Вхідний параметр
% n - довжина лінії
s = [];
for i = 1:n, s = [s '-']; end
displ(s)