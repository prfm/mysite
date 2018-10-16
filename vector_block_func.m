function y = vector_block_func(inputsize,vector)
% vertcat the input vector and outputvector of vdP eq.

n=size(vector,1);

if rem(n,inputsize) ~= 0
    disp('Wrong input to vector_block_func.');
    quit
end

y=0;
k=0;

while k*inputsize < n
    y = vertcat(y,van_der_Pol(); %#ok<AGROW>
    k = k+1;
end

end

