% parameters
eqname = 'van_der_Pol'; % the filename of right hand size function
y_initial = [2.0; 0];
Tend = 12;
h_initial = 10^(-3);
s = 3;
n = 2;
tol = 10^(-10);
 %#ok<*AGROW>

% Getting Runge-Kutta formula
% hat means embedded one
[A,b,c] = Gauss();
[Ahat,bhat] = embed(A,c);

% initical values
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
loop = 0;
RH = zeros(2,2);
FLAG = [1.0;0;0];
K = zeros(n*s,1);

% choose the stepsize controller
% 1 for the traditional one and 2 for the predictive one
controller = 1.0;

% main part
while t < Tend
    
    [yplus,error,K] = EGauss_iteration(y,h,A,b,bhat,K);
    E = horzcat(E,error);
    
    if controller == 1
        hnext = 0.9 * (tol/error)^(1/(s+1))*h;
    else
        [hnext,RH,FLAG] = predictive_controller(s,h,error,RH,FLAG,tol);
    end
    
    H = horzcat(H,hnext);
    
    while error > tol
        h = hnext;
        [yplus,error,K] = EGauss_iteration(y,h,A,b,bhat,K);
        E = horzcat(E,error);
        
        if controller == 1
            hnext = 0.9 * (tol/error)^(1/(s+1))*h;
        else
            [hnext,RH,FLAG] = predictive_controller(s,h,error,RH,FLAG,tol);
        end
        H = horzcat(H,hnext);
    end
    
    Eacc = horzcat(Eacc,error);
    Hacc = horzcat(Hacc,h);
    h = hnext;
    
    t = t+h;
    
    T = horzcat(T,t);
    Y = horzcat(Y,yplus);
    
    y = yplus;
    
end

pos = Y(1,:);
vel = Y(2,:);

Data=struct('Time',T,'Pos',pos,'Vel',vel,'Stepsize',H,'Stepsize_accepted',Hacc,'Error',E,'Error_accepted',Eacc);

