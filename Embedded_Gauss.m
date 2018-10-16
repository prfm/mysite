% parameters
eqname = 'van_der_Pol'; % the filename of right hand size function
y_initial = [2.0; 0];
Tend = 12;
h_initial = 10^(-3);
s = 3;
n = 2;
tol = 0.0001;
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
E = 0;
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
    
    h = hnext;
    H = horzcat(H,h);
    
    while error > tol
        [yplus,error,K] = EGauss_iteration(y,h,A,b,bhat,K);
        
        E = horzcat(E,error);
        if controller == 1
            hnext = 0.9 * (tol/error)^(1/(s+1))*h;
        else
            [hnext,RH,FLAG] = predictive_controller(s,h,error,RH,FLAG,tol);
        end
        
        h = hnext;
        H = horzcat(H,h);
    end
    
    t = t+h;
    
    loop = loop +1;
    if loop ==1000
        disp(t);
        loop = 0;
    end
    
    T = horzcat(T,t);
    Y = horzcat(Y,yplus);
    
    y = yplus;
    
end

Data=struct('Time',T,'Pos',pos,'Vel',vel,'Stepsize',H,'Error',E);

