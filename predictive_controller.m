function [hnext,RH,FLAG] = predictive_controller(s,h,error,RH,FLAG,tol)
% predictive stepsize controller given by Gustafsson

%parameters
k1=1.0;
k2=1.0;

k = s+1;

if error <= tol
    if FLAG(1) == 1 || FLAG(2) > 0 || FLAG(3) == 1
        hnext = (tol/error)^(1/k)*h;
    else
        hnext = (h/RH(1,2)) *(RH(1,1)/error)^(k1/k) *(tol/error)^(k2/k) * h;
    end
    
    RH(1,1) = error;
    RH(1,2) = h;
    FLAG = zeros(3,1);
else
    
    if FLAG(2) == 1.0
        kcat = log(error/RH(2,1))/log(h/RH(2,2));
        
        kcat = min(k,kcat);
        kcat = max(0.1,kcat);
        
        hnext = (tol/error)^(1/kcat)*h;
        
        hnext = max(hnext,0.1*h);
    else
    
    hnext = (tol/error)^(1/k)*h;
    end
    
    RH(2,1) = error ;
    RH(2,2) = h;
    
    FLAG(1) = 0;
    FLAG(2) = FLAG(2) + 0.25;
    FLAG(3) = 0;
end

[hnext,FLAG] = restrict(hnext,h,FLAG);

end

