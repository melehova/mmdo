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
            fun(2)
            fileID = fopen('temp.txt', 'w');
            switch fD.method
                case 'metStepAdaptation'
                    [P,F,i,x,fx] = metStepAdaptation(fun,fD.start,fD.step,fD.epsilon,fD.num);
                case 'metDichotomy'
                    [P,F,i,a,b] = metSvenn(fun,fD.start,fD.step,fD.num);
                    [P,F,i,x,fx] = metDichotomy(fun,P,F,i,a,b,fD.delta,fD.epsilon);
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
            fclose(fileID);
            fileID = fopen('temp.txt', 'r');
            content = '';
            while ~feof(fileID)
                tline = fgets(fileID);
                content = [content tline];
            end
            app.HTML.Data = jsonencode(struct('btnClicked', false, 'text', content));
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
            app.HTML.Data = '{"btnClicked":false,"text":null}';

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