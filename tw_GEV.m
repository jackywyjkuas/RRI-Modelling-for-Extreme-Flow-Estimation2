clc
clear
data = xlsread('AMS_qr_HPB.xlsx');
data2 = xlsread('AMS_qr_HFB.xlsx');
%%
for ii = 1:15
    qr = data(:,ii);
    qr2 = data2(:,ii);
    if ii == 5 | ii == 6 | ii == 7
        qr = data(:,ii)/1.5;
        qr2 = data2(:,ii)/1.5;
    elseif ii == 12 | ii == 13
        qr = data(:,ii)/2;
        qr2 = data2(:,ii)/2;
    elseif ii == 14
        qr = data(:,ii)/2.5;
        qr2 = data2(:,ii)/2.5;
    end
    %[parmhat2] = fitGEV(qr,'method','Gumbel');
    [parmhat] = fitGEV(qr,'method','moments');
    [parmhat2] = fitGEV(qr2,'method','moments');
    %[parmhat3] = fitGEV(meanU,'method','Gringorten');
    %[parmhat2] = fitGEV(x,'method','moments','dataPlot',1,'returnPeriod',2000);
    returnPeriod = 3000;
    x = ([1:numel(qr)])/(numel(qr)+1);
    x2 = ([1:numel(qr2)])/(numel(qr2)+1);

    r = 1./(1-x); %all 1500-y
    r2 = 1./(1-x2); %all 2700-y

    X = linspace(min(qr),2*max(qr),1e4);
    X2 = linspace(min(qr2),2*max(qr2),1e4);
    
    F  = mygevcdf(X,parmhat(1),parmhat(2),parmhat(3)); % for fitted parameters
    F2  = mygevcdf(X2,parmhat2(1),parmhat2(2),parmhat2(3)); % for fitted parameters
    R = 1./(1-F);
    R2 = 1./(1-F2);
    
    %figure
    clf
    box on;
    h1 = plot(r,sort(qr),'ko','markerfacecolor','k'); hold on % cdf
    h2 = plot(r2,sort(qr2),'ro','markerfacecolor','r'); hold on % cdf


    h3 = plot(R,X,'k'); %plot line
    h4 = plot(R2,X2,'r'); %plot line
    xlabel('Return period (years)');
    ylabel('AMS (m^3/s)');
    set(gca, 'XScale', 'log')
    axis tight
    ylim([0.9*min(X(R<returnPeriod)),1.1*max(qr2)])
    xlim([0,returnPeriod])
    legend([h1 h3 h2 h4],'Empirical HPB','GEV HPB','Empirical HFB','GEV HFB','location','SouthEast')
    
    grid on
    set(gcf,'color','w');
    imgname = sprintf('gev_p%.2d-legend.jpg',ii);
    %print(imgname, '-dpng', '-r300');
    %pause
    
    
    
    
    
    
    %% find return period
    % HPB
    for target = [10, 50, 100, 1000]    %target value return period
        RP_closest = interp1(R,R,target,'nearest');
        i = find (R == RP_closest);
        if target == 10
            HPB_10(ii) = X(i);
        elseif target == 50
            HPB_50(ii) = X(i);
        elseif target == 100
            HPB_100(ii) = X(i);
        elseif target == 1000
            HPB_1000(ii) = X(i);
        end
    end
    % HFB
    for target = [10, 50, 100, 1000]    %target value return period
        RP_closest = interp1(R2,R2,target,'nearest');
        i = find (R2 == RP_closest);
        if target == 10
            HFB_10(ii) = X2(i);
        elseif target == 50
            HFB_50(ii) = X2(i);
        elseif target == 100
            HFB_100(ii) = X2(i);
        elseif target == 1000
            HFB_1000(ii) = X2(i);
        end
    end
end
%% outfile
index(:,1) = HPB_10;
index(:,2) = HPB_50;
index(:,3) = HPB_100;
index(:,4) = HPB_1000;
index(:,5) = HFB_10;
index(:,6) = HFB_50;
index(:,7) = HFB_100;
index(:,8) = HFB_1000;

fod = sprintf('return_period.dat');
file_out = char(fod);
fopen(file_out,'w');
head = sprintf('HPB10 HPB50 HPB100 HPB1000 HFB10 HFB50 HFB100 HFB1000');
dlmwrite(file_out, head ,'delimiter','','-append');
dlmwrite(file_out, index ,'delimiter',' ','-append');

%[parmhat2] = fitGEV(qr,'method','moments','dataPlot',1,'returnPeriod',2000);

%% KS test
% H0: the two samples have no significant difference in CDF
% KS = 1 reject H0 (significant); KS = 0 accept H0 (not significant)
% p-value < 0.05, rejected H0

for ii = 1:15
    d1 = data(:,ii);
    d2 = data2(:,ii);
    if ii == 1
        [KS01,p_value_01] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 2
        [KS02,p_value_02] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 3
        [KS03,p_value_03] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 4
        [KS04,p_value_04] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 5
        [KS05,p_value_05] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 6
        [KS06,p_value_06] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 7
        [KS07,p_value_07] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 8
        [KS08,p_value_08] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 9
        [KS09,p_value_09] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 10
        [KS10,p_value_10] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 11
        [KS11,p_value_11] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 12
        [KS12,p_value_12] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 13
        [KS13,p_value_13] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 14
        [KS14,p_value_14] = kstest2(d1,d2,'Alpha',0.01);
    elseif ii == 15
        [KS15,p_value_15] = kstest2(d1,d2,'Alpha',0.01);
    end
end