% parameters
eqname = 'van_der_Pol'; % the filename of right hand size function
y_initial = [2; 0];
Tend = 12;
h_initial = 1.0;
s = 3;

% Getting Runge-Kutta formula
% hat means embedded one
[A,b,c] = Gauss();
[Ahat,bhat] = embed(A,c);

% capital values are the log vecters
h = h_initial;
H = h;
t = 0;
T = t;
y = y_initial;
Y = y;

k = zeros(s,1);

% main part
yplus = EGauss_iteration(y,h,A,b,c,Ahat,bhat,eqname) %#ok<NOPTS>