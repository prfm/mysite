function yplus = EGauss_iteration(y,h,A,b,c,Ahat,bhat,eqname)
    
    n = size(y,1); % order of the equation
    s = size(A,1); % number of steps
    
    options = optimoptions('fsolve','Display','off');
    
    UDF = @(X) reshape(X,[],1)-array_to_rowfunc(eqname,X);
    
    
    yplus = y + h*K*b;
    
end