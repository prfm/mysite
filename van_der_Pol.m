function [y_dif] = van_der_Pol(y)
 % The right hand side of van der Pol equation.
 % The value of sigma is defined in "van_der_Pol.m", but the initial value
 % should be determind outside.
    sigma = 5.0;
    y_dif = [y(2); sigma*(1-y(1)^2)*y(2) - y(1)];
end
        