function [Ahat,bhat] = embed(A,c)
% Returns the matrix A and vecter b of the embedded formula of Gauss formula.
    K = fliplr(vander(c))';
    right = c;
    
    for i = 1:size(c,1)
        right(i) = 1/i;
    end
    right(1) = right(1)-1/8;
    
    x = linsolve(K,right);
    
    bhat = vertcat(1/8,x);
    
    s = size(A,1);
    
    Ahat = horzcat(zeros(s,1),A);
    Ahat = vertcat(zeros(1,s+1),Ahat);
    
    
end
