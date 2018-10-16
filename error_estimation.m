function r = error_estimation(y_highorder,y_loworder,~)
% Define error estimation here
% Euclidian norm
    tol = 10^(-5);
    r = norm(y_highorder-y_loworder)/tol;

end

