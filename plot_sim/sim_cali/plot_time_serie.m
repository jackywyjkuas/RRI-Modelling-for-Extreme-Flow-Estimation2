
clc
clear all
clf
obs = xlsread('obs.xlsx');

i = 0;
for ifile = 1:15
    i = i + 1;
    infile = sprintf('disc_p%02d.txt',ifile);
    data = dlmread(infile);
    sim(i,:) = data(:,2);
end
%%
ifile = 1:15;
%% scatter plot
% start_t = 367; %flood event in 2001
% end_t = 731; 
% x = 1:365; 


% start_t = 2923; %flood event in 2008
% end_t = 3288; 
% x = 1:366; 

% start_t = 3289; %flood event in 2009
% end_t = 3653; 
% x = 1:365; 
% 
start_t = 6211; %flood event in 2017
end_t = 6575; 
x = 1:365; 


% start_t = 1; %flood event all
% end_t = 7671; 
% x = 1:7671; 




%%
for n = 1:i
    h1 = subplot(5,3,n);
    o = obs(:,n);
    s(:,1) = sim(n,:);
    
    plot(x,s(start_t:end_t),'k'); hold on
    plot(x,o(start_t:end_t),'-.r');
    set(gca,'TickDir','out');
    set(gca,'XTick',[1 32 60 91 121 152 182 213 244 274 305 335]);
    set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D'});
    
    set(gca,'XLim',[1 365]);
    if n == 1 
        legend('sim','obs', 'Location', 'NorthWest');
    end
    if n == 7
        ylabel('Discharge [m^3/s]')
    end

% 
%     m = max(max(o),max(s))+100;
%     scatter(o,s);
%     scatter(o(start_t:end_t),s(start_t:end_t));
%     line = lsline(h1);
%     line.Color = 'r';
%     set(gca,'XLim',[0 m],'YLim',[0 m]);
%     if n == 7
%         ylabel('Simulation [m^3/s]');
%     end
%      if n == 14
%          xlabel('Observation [m^3/s]');
%      end
%     
    
    
    tt = sprintf('Station %02d',n);
    title(tt);
    c = corrcoef(o,s,'rows','pairwise');
    cc(n) = c(2);
    
    ii = 0;
    for j = start_t:end_t
        if o(j,1) >= 0
            ii = ii + 1;
            oo(ii) = o(j,1);
            ss(ii) = s(j,1);
        end
    end
    [NSE(n),beta(n),aphla(n), r(n),KGE(n),PDR(n),RMSE(n)] = statistic(oo,ss);
    
end

%%

% 
% 
% print('sim_all.jpg', '-dpng', '-r300');
f = sprintf('CC_2017.txt');
fid = fopen(f, 'w');
fprintf(fid,'NSE r2 KGE PDR \n');
dlmwrite(f,NSE,'-append');
dlmwrite(f,r,'-append');
dlmwrite(f,KGE,'-append');
dlmwrite(f,PDR,'-append');


function [NSE, beta, alpha, r ,KGE, PDR, RMSE] = statistic(obs,sim)
    zz = size(obs);
    n = zz(2);
    avg_obs(1:n) = mean(obs);
    avg_sim(1:n) = mean(sim);
    NSE = 1-sum((sim-obs).^2)/sum((obs-avg_obs).^2);
    beta = avg_sim/avg_obs;
    alpha = sqrt(sum((sim-avg_sim).^2)/n)/(sqrt(sum((obs-avg_obs).^2)/n));
    r1 = sum((obs-avg_obs).*(sim-avg_sim));
    r2 = sqrt(sum(((obs-avg_obs).^2))*(sum((sim-avg_sim).^2)));
    r = r1/r2;
    KGE = 1-sqrt((r-1)^2+(beta-1)^2+(alpha-1)^2);
    PDR = max(sim)/max(obs);
    RMSE = sqrt(sum((sim-obs).^2)/n);
end
