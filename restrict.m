function [hnext,outFLAG] = restrict(h,FLAG)
%restrict the stepsize according to the equation solver
    
    hnext = h;
    outFLAG = FLAG;
    outFLAG(3) = 1.0;
end

