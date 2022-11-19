function [ g ] = Grad1( x,fx,f)
    d = 1e-8; a = 1/d;
    n = length(x); y = x; g = x;
    for i = 1:n
        y(i) = x(i) + d;
        fy = f(y);
        g(i) = (fy - fx)*a;
        y(i) = x(i);
    end
end