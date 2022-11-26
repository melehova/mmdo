function [X] = metPolRibFleRee(fun,P,F,i,X,e)
%METPOLRIB method Полака-Ріб'єра та Флетчера-Рівса
    % 1
    fx = fun(X);
    gx = Grad1(X,fx,fun);
    d = -gx;
    while true 
        % 2
        [P,F,i,a,b,c,fa,fb,fc] = SwanM(f,P,F,i,X,d);
        [P,F,i,u,fu] = metDichotomyM(f, P, F, i, a ,b,delta,E1,X,d);
        s = u*d; X = X + s; ns = norm(s);
        % 3
        s = u*D;
        X = X + s;
        gy = gx;
        % 4
        fx = fun(X);
        gx = Grad1(X,fx,fun);
        B = gx.'*(gx-gy)/(gy.'*gy);
        d = -gx + B*d;
        if (abs(s) <= e)
            break
        end
    end



end