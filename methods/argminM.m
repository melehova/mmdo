function [P,F,i,u,fx] = argminM(met,fun,P,F,i,delta,epsilon,step,x0,d)
    switch met
        case 'metStepAdaptationM'
            [P,F,i,u,fx] = metStepAdaptationM(fun,P,F,i,step,epsilon,x0,d);
        case 'metDichotomyM'
            [P,F,i,a,b] = SwanM(fun,P,F,i,x0,d);
            [P,F,i,u,fx] = metDichotomyM(fun,P,F,i,a,b,delta,epsilon,x0,d);
        case 'metI3p4M'
            [P,F,i,a,b,c,fa,fb,fc] = SwanM(fun,P,F,i,x0,d);
            % Виклик метода кубічної інтерполяції з 4 точками
            [P,F,i,u,fx] = metI3p4M(fun,P,F,i,a,b,c,fa,fb,fc,epsilon,x0,d);
        otherwise
            method = str2func(met);
            [P,F,i,a,b] = SwanM(fun,P,F,i,x0,d);
            [P,F,i,u,fx] = method(fun,P,F,i,a,b,epsilon,x0,d);
    end
end