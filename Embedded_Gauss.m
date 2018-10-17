% parameters
%eqname = 'van_der_Pol'; % the filename of right hand size function
y_initial = [2.0; 0];
Tend = 10;
h_initial = 10^(-3);
s = 3;
n = 2;
tol = 10^(-10);

% norm difinition
% way = 1 means Gustafsson's norm
% way = 2 means Euclidean norm
way = 1;

% choose the stepsize controller
% 1 for the traditional one and 2 for the predictive one
controller = 1.0;

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
    else
        [hnext,RH,FLAG] = predictive_controller(s,h,error,RH,FLAG,tol);
    end
    
    H = horzcat(H,hnext);
    
    while error > tol
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
    end
    
    State = horzcat(State,1);
    Eacc = horzcat(Eacc,error);
    Hacc = horzcat(Hacc,h);
    h = hnext;
    
    t = t+h;
    
    T = horzcat(T,t);
    Y = horzcat(Y,yplus);
    
    y = yplus;
    
end

State = horzcat(State,1);
pos = Y(1,:);
vel = Y(2,:);

Data=struct('Time',T,'Pos',pos,'Vel',vel,'Stepsize',H,'Stepsize_accepted',Hacc,'Error',E,'Error_accepted',Eacc);
