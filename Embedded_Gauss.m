% parameters
eqname = 'van_der_Pol'; % the filename of right hand size function
y_initial = [2; 0];
Tend = 12;
h_initial = 0.001;
s = 3;

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
E = 0;

flag = 0;
% main part
while t < Tend
    [yplus,err] = EGauss_iteration(y,h,A,b,bhat);
    flag = flag +1;
    t = t+h;
    if flag ==1000
        disp(t);
        flag = 0;
    end
    T = horzcat(T,t);
    Y = horzcat(Y,yplus);
    y = yplus;
    
    
    h= 0.9*(1/err)^(1/(s+1))*h;
    
    H = horzcat(H,h);
    
    if h < 10^(-10)
        disp('  Too short stepsize')
        break;
    end
    
    E = horzcat(E,err);
    
end

pos = Y(2,:);
vel = Y(1,:);
plot(pos,vel);