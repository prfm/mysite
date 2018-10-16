% parameters
eqname = 'van_der_Pol'; % the filename of right hand size function
y_initial = [2.0; 0];
Tend = 12;
h_initial = 0.001;
s = 3;
tol = 10^(-4);

%#ok<*AGROW>
% Getting Runge-Kutta formula
% hat means embedded one
[A,b,c] = Gauss();
[Ahat,bhat] = embed(A,c);

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

flag = 0;
% main part
while t < Tend
    
    [yplus,err,hnext] = EGauss_iteration(y,h,A,b,bhat,tol);
    H = horzcat(H,hnext);
    E = horzcat(E,err);
    
    while err > tol
        h = hnext;
        [yplus,err,hnext] = EGauss_iteration(y,h,A,b,bhat,tol);
        E = horzcat(E,err);
        H = horzcat(H,hnext);
    end
    
    Hacc = horzcat(Hacc,h);
    h = hnext;
    
    Eacc = horzcat(Eacc,err);
   
    t = t+h;
    
    T = horzcat(T,t);
    Y = horzcat(Y,yplus);
    
    y = yplus;
    
    
end

Hacc = horzcat(Hacc,h);

pos = Y(1,:);
vel = Y(2,:);

Data=struct('Time',T,'Pos',pos,'Vel',vel,'Stepsize',H,'Stepsize_accepted',Hacc,'Error',E,'Error_accepted',Eacc);
