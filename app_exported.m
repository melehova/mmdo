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
            switch htmlData.funcType
                case 'mult-dem'
                    switch fD.multMethod
                        case 'steepest'
                            x0 = fD.start.';
                            N = fD.num;
                            n = length(x0);
                            P = zeros(n,N); F = zeros(1,N);
                            fx = fun(x0);
                            k = 0;
                            i = 1; P(:,i) = x0; F(i) = fx;
                            ns = 1;
                            % E1 = E;
                            g = Grad1(x0, fx,fun);
                            while ns > fD.epsilonm 
                                k = k + 1;
                                d = -g;
                                nd = norm(d);
                                if nd > 0
                                    dn = d/nd;
                                else
                                    disp('zero vector route');
                                    Graph3(fun,P,F)
                                    return
                                end
                                switch fD.method
                                    case 'metStepAdaptationM'
                                        [P,F,i,u,fx] = metStepAdaptationM(fun,P,F,i,fD.step,fD.epsilon,x0,d);
                                    case 'metDichotomyM'
                                        [P,F,i,a,b] = SwanM(fun,P,F,i,x0,d);
                                        [P,F,i,u,fx] = metDichotomyM(fun,P,F,i,a,b,fD.delta,fD.epsilon,x0,d);
                                    case 'metI3p4M'
                                        [P,F,i,a,b,c,fa,fb,fc] = SwanM(fun,P,F,i,x0,d);
                                        % Виклик метода кубічної інтерполяції з 4 точками
                                        [P,F,i,u,fx] = metI3p4M(fun,P,F,i,a,b,c,fa,fb,fc,fD.epsilon,x0,d);
                                    otherwise
                                        method = str2func(fD.method);
                                        [P,F,i,a,b] = SwanM(fun,P,F,i,x0,d);
                                        [P,F,i,u,fx] = method(fun,P,F,i,a,b,fD.epsilon,x0,d);
                                end
                                % [P,F,i,a,b,c,fa,fb,fc] = SwanM(f,P,F,i,x0,d);
                                % [P,F,i,u,fx] = metDichotomyM(f, P, F, i, a ,b,delta,E1,x0,d);
                                s = u*d; x0 = x0 + s; ns = norm(s);
                                displ('Метод найшвидшого спуска')
                                line2sn(45);
                                displ('     k     ns      fx       x1        x2')
                                line2sn(45);
                                displ([i2s5(k) r2s10(ns) r2s10(fx) v2s(x0)])
                                line2sn(45);
                                g = Grad1(x0,fx,fun);
                            end
                            Graph3(fun,P,F)
                    end
                case 'one-dem'
                    switch fD.method
                        case 'metStepAdaptation'
                            [P,F,i,x,fx] = metStepAdaptation(fun,fD.start,fD.step,fD.epsilon,fD.num);
                        case 'metDichotomy'
                            [P,F,i,a,b] = metSvenn(fun,fD.start,fD.step,fD.num);
                            [P,F,i,x,fx] = metDichotomy(fun,P,F,i,a,b,fD.delta,fD.epsilon);
                        case 'metI3p4'
                            [P,F,i,a,b,c,fa,fb,fc] = metSvenn(fun,fD.start,fD.step,fD.num);
                            % Виклик метода кубічної інтерполяції з 4 точками
                            [P,F,i,x,fx] = metI3p4(fun,P,F,i,a,b,c,fa,fb,fc,fD.epsilon);
                        otherwise
                            method = str2func(fD.method);
                            [P,F,i,a,b] = metSvenn(fun,fD.start,fD.step,fD.num);
                            [P,F,i,x,fx] = method(fun,P,F,i,a,b,fD.epsilon);
                    end
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
            app.UIFigure.Name = 'Matlab App Veronika Melekhova';

            % Create HTML
            app.HTML = uihtml(app.UIFigure);
            app.HTML.HTMLSource = 'index.html';
            app.HTML.DataChangedFcn = createCallbackFcn(app, @HTMLDataChanged, true);
            app.HTML.Position = [1 1 842 480];
            app.HTML.Data = '{"btnClicked":false,"text":null,"funcType":"two-dem"}';

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
