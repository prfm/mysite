function y = vector_block_func(funcname,inputsize,vector)
% Apply the elements of the vector to the function whose inputsize is
% smaller than that of the vector. First, input 1,2,...,inputsize -th
% elements and then inputsize+1,...,2*inputsize -th elements and so on,

if rem(size(vector,1),inputsize) ~= 0
    disp('Wrong input to vector_block_func.');
    quit
end



end

