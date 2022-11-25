function [P,F,i,x,fx] = argmin(met,fun,P,F,i,delta,epsilon,step,start,num)
    switch met
        case 'metStepAdaptation'
            [P,F,i,x,fx] = metStepAdaptation(fun,start,step,epsilon,num);
        case 'metDichotomy'
            [P,F,i,a,b] = metSvenn(fun,start,step,num);
            [P,F,i,x,fx] = metDichotomy(fun,P,F,i,a,b,delta,epsilon);
        case 'metI3p4'
            [P,F,i,a,b,c,fa,fb,fc] = metSvenn(fun,start,step,num);
            % Виклик метода кубічної інтерполяції з 4 точками
            [P,F,i,x,fx] = metI3p4(fun,P,F,i,a,b,c,fa,fb,fc,epsilon);
        otherwise
            method = str2func(fD.method);
            [P,F,i,a,b] = metSvenn(fun,start,step,num);
            [P,F,i,x,fx] = method(fun,P,F,i,a,b,epsilon);
    end
end