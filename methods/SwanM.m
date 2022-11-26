function [ P,F,i,a,b,c,fa,fb,fc ] = SwanM(f,P,F,i,X,D)
    displ('Метод Свенна')
    line2sn(35)
    displ('     i     h         fx    x1        x2')
    line2sn(35)
    fc = f(X);c = 0; h = 1;
    i = i + 1; P(:,i) = X; F(i) = fc;
    displ([i2s5(i) r2s10(h) r2s10(fc) v2s(X)])
    b = c + h; Y = X + b*D; fb = f(Y);
    i = i + 1; P(:,i) = Y; F(i) = fb;
    displ([i2s5(i) r2s10(h) r2s10(fc) v2s(Y)])
    if fb < fc
        while fb < fc
            a = c; fa = fc; c = b;
            fc = fb; h = h+h; b = c + h; 
            Y = X + b*D; fb = f(Y);
            i = i + 1; P(:,i) = Y; F(i) = fb;
            displ([i2s5(i) r2s10(h) r2s10(fc) v2s(Y)])
        end
    else 
            h = -h; a = c + h;
            Y = X + a*D; fa = f(Y);
           i= i + 1; P(:,i) = Y; F(i) = fa;
           displ([i2s5(i) r2s10(h) r2s10(fa) v2s(Y)])
           while fa < fc
               b = c; fb = fc; c = a; fc = fa;
               h = h + h; a = c + h; Y = X +a*D; fa = f(Y);
               i = i + 1; P(:,i) = Y; F(i) = fa;
               displ([i2s5(i) r2s10(h) r2s10(fa) v2s(Y)])
           end   
    end
    
    if  a > b
        d = a; fd = fa; a = b; fa = fb;
        b = d;fb = fd;
    end
    line2sn(35)
end