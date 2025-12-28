clear all;
clc

%for i = [1:10, 21:30, 41:50, 61:70, 81:90]
for p = 1:15
    j = 0;
    for i = [101:115]
        filename = sprintf('./m%.3d/disc_p%.2d.txt',i,p);
        data = dlmread(filename);
        qr = data(:,2);
        t2 = 0;
        y = 0;
        for year = 1:30
            j = j + 1;
            y = y + 1;
            if mod(year,4) == 0
                nday = 366;
            else
                nday = 365;
            end
            t1 = t2 + 1;
            t2 = t1 + nday - 1;
            ams(y,p) =  max(qr(t1:t2));  %max 1-day
            ams_qr(j,p) = ams(y,p);
            t1 = t2;
        end
    end
end

xlswrite('AMS_qr.xlsx',ams_qr);
