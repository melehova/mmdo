function [ g, H ] = GradHes2( fun,x,fx )
    d = 1e-6;
    n = length(x);
    a = 1/(2*d); b = 1/(d*d);
    y = x; z = x; g = x; F = x; H = eye(n);
    for i = 1:n
        y(i) = x(i) + d;
        fy = fun(y);
        F(i) = fy;
        z(i) = x(i) - d;
        fz = fun(z);
        g(i) = (fy - fz)*a;
        H(i,i) = (fy - 2*fx + fz)*b;
        y(i) = x(i); z(i) = x(i);
    end
    for i = 1:n-1
        y(i) = y(i) + d;
        for j = 1+1:n
            y(j) = y(j) + d;
            fy = fun(y);
            H(i,j) = ((fy - F(i)) + (fx - F(j))) * b;
        end
        y(i) = x(i);
    end
end