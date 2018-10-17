function [hnext,outFLAG] = restrict(hnext,h,FLAG)
%restrict the stepsize according to the equation solver
    outFLAG = FLAG;
    if hnext > 2*h
        hnext = 2*h;
        outFLAG(3) = 1.0;
        disp('RESTRICTION')
        disp(hnext)
        disp(h)
    end
end

