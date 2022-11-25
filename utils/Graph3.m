function Graph3( fun, P, F )
    C = colormap;
    n = 100; n1 = n + 1;
    a = min(P,[],2); b = max(P,[],2); N = length(F);
    ax = a(1); ay = a(2);
    bx = b(1); by = b(2);
    hx = (bx - ax)/n;
    hy = (by - ay)/n;
    x = ax:hx:bx;
    y = ay:hy:by;
    [yy,xx] = meshgrid(y,x);
    ff = zeros(n1,n1);
    for j = 1:n1
        y1 = y(j);
        for i = 1:n1
            xy = [x(i); y1];
            ff(i,j) = fun(xy);
        end
    end
    figure(1)
    hold on
    set(gcf,'Color','w')
    colormap(C); surf(xx,yy,ff)
    hold on
    plot3(P(1,:),P(2,:),F,'go-')
    plot3(P(1,1),P(2,1),F(1),'ro')
    plot3(P(1,N),P(2,N),F(N),'yo','MarkerSize',16)
    axis([a(1),b(1),a(2),b(2)])
    xlabel('\itx\rm_1'), ylabel('\itx\rm_2')
    zlabel('\itf','Rotation',90)
    grid on, box on, rotate3d on
end

