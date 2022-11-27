function [y,fy] = R(fun,x,fx,d)
%R Досліджуючий пошук
    n = length(x);
    y = x;
    fy = fx;
    u = y;
    i = 0;
    while i < n
        i = i + 1;
        u(i) = y(i) + d;
        fu = fun(u);
        if fu < fy
            y(i) = u(i);
            fy = fu;
        else
            u(i) = y(i) - d;
            fu = fun(u);
            if fu < fy
                y(i) = u(i);
                fy = fu;
            else
                u(i) = y(i);
            end
        end
    end
end