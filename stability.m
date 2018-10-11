[A,b,c] = Gauss();

N = 100;
x = linspace(-15,15,N);
y = x;
[X,Y] = meshgrid(x,y);

local_stability_func_1 = @(z) abs(stability_func(A,b,z));

Z1 = arrayfun(local_stability_func_1,X+sqrt(-1)*Y);

[Ahat,bhat] = embed(A,c);

local_stability_func_2 = @(z) abs(stability_func(Ahat,bhat,z));

Z2 = arrayfun(local_stability_func_2,X+sqrt(-1)*Y);

Z = max(Z1,Z2);

v = [0,1];
contourf(X,Y,Z,v)
