% Set parameters in Star_calcuration.m
%#ok<*AGROW>

% Getting Runge-Kutta formula
% hat means embedded one
[A,b,c] = Gauss();
[Ahat,bhat] = embed(A,c);

% initial values
% capital values are the log vecters
t = 0;
T = t;
y = y_initial;
Y = y;
h = h_initial;
H = h;
Hacc = 0;
E = 0;
Eacc = 0;
State = [];
RH = zeros(2,2);
FLAG = [1.0;0;0];
K = zeros(n*s,1);

% main part
while t < Tend
    
    [yplus,error,K] = EGauss_iteration(y,h,A,b,bhat,K,way);
    E = horzcat(E,error);
    
    if controller == 1
        hnext = (tol/error)^(1/(s+1))*h;
        if hnext == 0 || hnext == inf
            disp(' INAPPROPRIATE STEPSIZE')
            disp(hnext)
            break
        end
    else
        [hnext,RH,FLAG] = predictive_controller(s,h,error,RH,FLAG,tol);
    end
    
    H = horzcat(H,hnext);
    
    while error > mu*tol
        State = horzcat(State,0);
        h = hnext;
        [yplus,error,K] = EGauss_iteration(y,h,A,b,bhat,K,way);
        E = horzcat(E,error);
        
        if controller == 1
            hnext = (tol/error)^(1/(s+1))*h;
        else
            [hnext,RH,FLAG] = predictive_controller(s,h,error,RH,FLAG,tol);
        end
        H = horzcat(H,hnext);
        if hnext == 0 || hnext == inf
            break
        end
    end
    
    State = horzcat(State,1);
    Eacc = horzcat(Eacc,error);
    Hacc = horzcat(Hacc,h);
    h = hnext;
    
    t = t+h;
    
    T = horzcat(T,t);
    Y = horzcat(Y,yplus);
    
    y = yplus;
    if hnext == 0 || hnext == inf
        disp(' INAPPROPRIATE STEPSIZE')
        disp(hnext)
        break
    end
end

State = horzcat(State,1);
pos = Y(1,:);
vel = Y(2,:);

Data=struct('Time',T,'Pos',pos,'Vel',vel,'Stepsize',H,'Stepsize_accepted',Hacc,'Error',E,'Error_accepted',Eacc,'State',State);
