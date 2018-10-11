function [A,b,c]=Gauss()
% Returns the matrix A, the vecter b and c of 3-step 6-order Gauss formula.
   A=[5/36 2/9-sqrt(15)/15 5/36-sqrt(15)/30;
       5/36+sqrt(15)/24 2/9 5/36-sqrt(15)/24;
       5/36+sqrt(15)/30 2/9+sqrt(15)/15 5/36];
   b=[5/18; 4/9; 5/18];
   c=[1/2-sqrt(15)/10; 1/2; 1/2+sqrt(15)/10];
   
end