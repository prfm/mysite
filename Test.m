for i=1:2
    for j=1:2
        way = i;
        controller = j;
        run('Embedded_Gauss.m')
        hold on
        plot(Data.Time,Data.Pos);
        clearvars -except i j
    end
end
        