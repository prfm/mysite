function r = error_estimation(y_highorder,y_loworder,y)
% Define error estimation here
% Koya Tomonori's way    
    ATOL=0;
    RTOL=10^(-8);
    
    
    n = size(y_highorder,1);
    err = abs(y_highorder - y_loworder);
    
    r=0;
    
    for i = 1:n
        tol = ATOL + RTOL * max(abs(y_highorder(i)),abs(y(i)));
        r = r + (err(i)/tol)^2;
    end
    
    r = r/n;
    
    r = sqrt(r);

end

