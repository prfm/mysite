function y = stability_func(A,b,z)
    s = size(A,1);
    y = det(eye(s)-z*A+z*ones(s,1)*b')/det(eye(s)-z*A);
end

