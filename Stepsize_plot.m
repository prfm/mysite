function [] = Stepsize_plot(H,S)
% Plot the stepsize with its status: whether it is accepted or not
    figure
    
    HA = H;
    HR = H;
    
    for i=1:size(S,2)
        if S(i) == 1
            HR(i) = nan;
        else
            HA(i) = nan;
        end
    end
    
    stem(HR,'LineStyle','none','Color','r')
    hold on
    stem(HA,'LineStyle','none','Color','b')
    
            

end

