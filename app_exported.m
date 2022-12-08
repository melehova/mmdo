classdef app_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure  matlab.ui.Figure
        HTML      matlab.ui.control.HTML
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Data changed function: HTML
        function HTMLDataChanged(app, ~)
            htmlData = jsondecode(app.HTML.Data);
            % formData
            fD = htmlData.formData;
            fun = str2func(strcat('@(x)',fD.function));
            % test fun 
            % fun([2 4]);
            fileID = fopen('temp.txt', 'w');
            x0 = fD.start.'; N = fD.num; n = length(x0);
            P = zeros(n,N); F = zeros(1,N); fx = fun(x0);
            k = 0; i = 0; ns = 1;
            switch htmlData.funcType
                case 'mult-dem'
                    x0 = fD.start.'; N = fD.num; n = length(x0);
                    P = zeros(n,N); F = zeros(1,N); fx = fun(x0);
                    k = 0; i = 0; ns = 1;
                    switch fD.multMethod
                        case 'metNewton'
                            [P,F,i,x,fx] = metNewton(fun,P,F,i,x0,fD.epsilonm,fD.delta,fD.epsilon,fD.step,fD.method);
                            Graph3(fun,P,F)
                        case 'metHookeJeeves'
                            [P,F,i,x,fx] = metHookeJeeves(fun,P,F,i,x0,fD.epsilonm,fD.step);
                            P(:,i+1:fD.num) = [];F(:,i+1:fD.num) = [];

                            Graph3(fun,P,F)
                        otherwise
                            gx = Grad1(x0,fx,fun);
                            d = -gx;
                            while ns > fD.epsilonm 
                                k = k + 1;
                                nd = norm(d);
                                if nd > 0
                                    dn = d/nd;
                                else
                                    disp('zero vector route');
                                    Graph3(fun,P,F)
                                    return
                                end
                                [P,F,i,u,fx] = argminM(fD.method,fun,P,F,i,fD.delta,fD.epsilon,fD.step,x0,d);
                                s = u*d; x0 = x0 + s; ns = norm(s);
                                gy = gx;
                                gx = Grad1(x0,fx,fun);                        
                                switch fD.multMethod
                                    case 'steepest'
                                        displ('Метод найшвидшого спуску')
                                        d = -gx;
                                    case 'metFletcherReeves'
                                        displ('Метод Флетчера-Рівса')
                                        B = (gx.'*gx)./(gy.'*gy); % flet
                                        d = -gx+B(2,2)*d;
                                    case 'metPolackRibier'
                                        displ("Метод Полака-Рів'єра")
                                        B = gx.'*(gx-gy)./(gy.'*gy); % pol
                                        d = -gx+B(2,2)*d;
                                end
                                line2sn(45);
                                displ('     k     ns      fx       x1        x2')
                                line2sn(45);
                                displ([i2s5(k) r2s10(ns) r2s10(fx) v2s(x0)])
                                line2sn(45);
                                Graph3(fun,P,F)
                            end
                    end
                case 'two-dem'
                    [P,F,i,x,fx] = argmin(fD.method,fun,P,F,i,fD.delta,fD.epsilon,fD.step,fD.start,fD.num);
                    P(i+1:fD.num) = [];F(i+1:fD.num) = [];
                    displ(['fx = ' num2str(fx) ' x = ' num2str(x)])
                    [dfx,d2fx] = der2(fun,x,fx);
                    displ(['dfx = ' num2str(dfx) ' d2fx = ' num2str(d2fx)])
                    % побудова графіка процесу
                    graphfun1(fun,P,F)
            end
            fclose(fileID);
            fileID = fopen('temp.txt', 'r');
            content = '';
            while ~feof(fileID)
                tline = fgets(fileID);
                content = [content tline];
            end
            app.HTML.Data = jsonencode(struct('btnClicked', false,'funcType', htmlData.funcType, 'text', content));
            fclose(fileID);      
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 841 480];
            app.UIFigure.Name = 'Matlab App Veronika Melekhova ';

            % Create HTML
            app.HTML = uihtml(app.UIFigure);
            app.HTML.HTMLSource = 'index.html';
            app.HTML.DataChangedFcn = createCallbackFcn(app, @HTMLDataChanged, true);
            app.HTML.Position = [1 1 842 480];
            app.HTML.Data = '{"btnClicked":false,"text":null,"funcType":"mult-dem"}';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end