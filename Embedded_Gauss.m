% parameters
eqname = 'van_der_Pol'; % the filename of right hand size function
y_initial = [0.5; 0];
Tend = 20;
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
    
    [yplus,err,hnext] = EGauss_iteration(y,h,A,b,bhat);
    
    E = horzcat(E,err);
    while err > 1
        E = horzcat(E,err);
        [yplus,err,hnext] = EGauss_iteration(y,hnext,A,b,bhat);
    end
    
    if hnext == inf
        disp('  infinity stepsize');
        break;
    end
    
    h = hnext;
    H = horzcat(H,h);
    
    flag = flag +1;
    t = t+h;
    if flag ==1000
        disp(t);
        flag = 0;
    end
    
    T = horzcat(T,t);
    Y = horzcat(Y,yplus);
    
    y = yplus;
    
    
end

pos = Y(2,:);
vel = Y(1,:);
plot(pos,vel);
xlim([-4,4]);
ylim([-4,4]);