function r = error_estimation(y_highorder,y_loworder,~)
% Define error estimation here
% Gustafsson's way
    n = size(y_highorder,1);
    
    % scaling factors
    scal = 10^(-2) * ones(n,1);
    
    err = abs(y_highorder - y_loworder);
    
    r=0;
    
    for i = 1:n
        r = r + (err(i)/(abs(y_highorder(i))+scal(i)))^2;
    end
    
    
    
    r = sqrt(r);
    
end

