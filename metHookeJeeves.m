function [P,F,i,X,fx] = metHookeJeeves(fun,P,F,i,X,E,step)
    fx = fun(X);
    step = 2 * step;
    displ("Метод Хука-Дживса")
    line2sn(45);
    displ('     i     step      fx       x1        x2')
    line2sn(45);
    while step >= E
        step = step / 2;
        % Досліджуючий пошук 1
        i = i + 1;
        P(:,i) = X; F(i) = fx;
        displ([i2s5(i) r2s10(step) r2s10(fx) v2s(X)])
        [y,fy] = R(fun,X,fx,step);
        if fy >= fx
            continue
        end
        while true
            % Пошук за зразком
            z = 2 * y - X;
            fz = fun(z);
            i = i + 1;
            P(:,i) = z; F(i) = fz;
            displ([i2s5(i) r2s10(step) r2s10(fx) v2s(X)])
            X = y;
            fx = fy;
            % Досліджуючий пошук 2
            [y,fy] = R(fun,z,fz,step);
            if fy >= fx
                break
            end
        end
    end
    line2sn(45);
    displ(['fx = ' num2str(fx) ' x = ' v2s(X)])
    [dfx,d2fx] = der2(fun,X,fx);
    displ(['dfx = ' num2str(dfx) ' d2fx = ' num2str(d2fx)])
end