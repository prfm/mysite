function yplus = EGauss_iteration(y,h,A,b,bhat)
    
    n = size(y,1); % order of the equation
    s = size(A,1); % number of steps
    
    UDF = @(X) X-vdP_vec(y,h,A,X);
    
    K = fsolve(UDF,zeros(n*s,1));
    
    K = reshape(K,n,s);
    
    
    
    yplus=y+h*K*b;
end