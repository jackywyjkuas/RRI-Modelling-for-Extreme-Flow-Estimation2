
clc
clear all
clf
obs = xlsread('obs_3940.xlsx');

i = 0;
for ifile = [2,3,4,6,8,9,10,12,13,15,16,20,21,23,24,25,29,30,31,33,36,37,42,45,46,47]
    i = i + 1;
    infile = sprintf('disc_p%02d.txt',ifile);
    data = dlmread(infile);
    sim(i,:) = data(:,2);
end

ifile = [2,3,4,6,8,9,10,12,13,15,16,20,21,23,24,25,29,30,31,33,36,37,42,45,46,47];
%% scatter plot
for n = 1:i
    h1 = subplot(6,5,n);
    o = obs(:,n);
    s = sim(n,:);
    scatter(o,s);
    line = lsline(h1);
    line.Color = 'r';
    tt = sprintf('river id:%02d',ifile(n));
    title(tt);
    c = corrcoef(o,s,'rows','pairwise');
    cc(n) = c(2);
    zz = size(sim);
    ii = 0;
    for j =1:zz(2)
        if o(j,1) >= 0
            ii = ii + 1;
            oo(ii) = o(j,1);
            ss(ii) = s(1,j);
        end
    end
    [NSE(n),beta(n),aphla(n), r(n),KGE(n),PDR(n),RMSE(n)] = statistic(oo,ss);
end

%%



%print('sim_old.jpg', '-dpng', '-r300');
fid = fopen('CC_sim.txt', 'w');
fprintf(fid,'NSE r2 KGE PDR \n');
dlmwrite('CC_sim.txt',NSE,'-append');
dlmwrite('CC_sim.txt',r,'-append');
dlmwrite('CC_sim.txt',KGE,'-append');
dlmwrite('CC_sim.txt',PDR,'-append');


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