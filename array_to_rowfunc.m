function y = array_to_rowfunc(funcname,matrix)
% Apply every row of the matrix to a function and vertcat them all.
% Main purpose is to apply it to fsolve.

    m = size(matrix,2);
    
    y = 0;
    
    for i=1:m
        z = funcname(matrix(:,i);
        y = vertcat(y,z);
    end
    
end

