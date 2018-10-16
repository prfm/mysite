function z = vdP_vec(y,h,A,klong)
    s = size(A,1);
    z = van_der_Pol(inputmaker(y,A,h,klong,1));
    
    if s > 1 
        for j=2:s
            z = vertcat(z,van_der_Pol(inputmaker(y,A,h,klong,j)));
        end
    end
end

function z = inputmaker(y,A,h,klong,index)
% Return the index-th input of the function 
    n = size(y,1);
    s = size(A,1);
    
    z = zeros(n,1);

    
    for i=1:s
        z = z + h*A(index,i)*klong(n*(i-1)+1:n*i);
    end
    
    z = z + y;
end

