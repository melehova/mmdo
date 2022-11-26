function [P,F,i,X,fx] = metNewton(fun,P,F,i,X,E,delta,epsilon,step,method1)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    k = 0;
    while true
        k = k + 1;
        fx = fun(X);
        [ g, H ] = gradhes(fun,X,fx);
        d = (-H\g.').';
        [P,F,i,u,fx] = argminM(method1,fun,P,F,i,delta,epsilon,step,X,d);
        s = u*d; ns = norm(s);
        X = X + s;
        displ("Метод Ньютона з одновимірним пошуком")
        line2sn(45);
        displ('     k     ns      fx       x1        x2')
        line2sn(45);
        displ([i2s5(k) r2s10(ns) r2s10(fx) v2s(X)])
        line2sn(45);
        if abs(s) <= E
            break
        end
    end
end