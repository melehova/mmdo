function s = r2s(r)
% Перетворення дійсного числа в рядок з 10 позицій
% Вхідний параметр:
%   r - дійсне число
% Вихідний параметр:
%   s - строковое представлення дійсного числа

if r == 0,  s = '   0      ';
else a = abs(r); l = log10(a);
   p = floor(l); % порядок числа
   switch p
      case -2, s = ['  ' num2str(r,3)];
      case -1, s = ['  ' num2str(r,4)];
      case  0, s = ['  ' num2str(r,5)];
      case  1, s = [' ' num2str(r,6)];
      otherwise
      if p == 2 && r > 0, s = num2str(r,7);
      else
         al = abs(p); lal = log10(al);
         n = sign(p)*fix(lal); m = r * 10^(-p);
         sp = int2str(p);
      switch n
         case -2, s = ['  ' num2str(m,1) 'e' sp];
         case -1, s = ['  ' num2str(m,2) 'e' sp];
         case  0, s = ['  ' num2str(m,3) 'e' sp];
         case  1, s = ['  ' num2str(m,2) 'e' sp];
         case  2, s = ['  ' num2str(m,1) 'e' sp];
      otherwise,  s = [' ' num2str(r,8)];
      end
      end
   end
   if r > 0,  s = [' ' s]; end
   n = length(s);
   if n < 10,  k = 10 - n;
      for i = 1:k,  s = [s ' ']; end
   end
end