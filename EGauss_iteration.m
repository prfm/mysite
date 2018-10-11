function [yplus,error,hnext] = EGauss_iteration(y,h,A,b,bhat)
    
    n = size(y,1); % order of the equation
    s = size(A,1); % number of steps
    
    UDF = @(X) X-vdP_vec(y,h,A,X);
    
    options = optimoptions('fsolve','Display','none');
    K = fsolve(UDF,zeros(n*s,1),options);
    
    K = reshape(K,n,s);
    
    yplus = y + h*K*b;
    yplus_loworder = y + h *(van_der_Pol(y) * bhat(1)+ K * bhat(2:s+1));
    
    error = error_estimation(yplus,yplus_loworder,y);    
    
    hnext= 0.9*(1/error)^(1/(s+1))*h;
    
end