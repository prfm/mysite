function r = error_estimation(y_highorder,y_loworder,way)
% Define error estimation here
% Third input defines the norm: 1 for Gustafsson's and 2 for Euclidean
    
    if way == 1
        % Gustafsson's way
        n = size(y_highorder,1);

        % scaling factors
        scal = 10^(-4) * ones(n,1);

        err = abs(y_highorder - y_loworder);

        r=0;

        for i = 1:n
            r = r + (err(i)/(abs(y_highorder(i))+scal(i)))^2;
        end

        r = sqrt(r);
    elseif way == 2
        % Eulcidean norm
        r = norm(y_highorder-y_loworder);
    end
    
end

