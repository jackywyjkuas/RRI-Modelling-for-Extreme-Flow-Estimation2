clc
clear all
clf
data = xlsread('result_index.xlsx','index');
index = data(3:17,2:16); %(riv_id, index)
riv = 1:15;
r2_2001(1,:) = index(:,1);
r2_2001(1,:) = index(:,1);
%% r2
subplot(3,1,1)
scatter(riv,index(:,1),'o','r'); hold on %year 2001
scatter(riv,index(:,4),'*','g');  hold on %year 2008
scatter(riv,index(:,7),'>','b'); hold on %year 2009
scatter(riv,index(:,10),'<','m'); hold on %year 2017
scatter(riv,index(:,13),'x','k'); %year 2000-2020
legend('2001','2008','2009','2017','2000-2020','NumColumns',5);
set(gca,'YLim',[0 1],'XLim',[.5 15.5]);
set(gca,'XTick',[1:15]);
set(gca,'YTick',[0:.2:1]);
set(gca,'xticklabel',{[]})
ylabel('r');
grid on
box on
%% KGE
subplot(3,1,2)
scatter(riv,index(:,2),'o','r'); hold on
scatter(riv,index(:,5),'*','g');  hold on
scatter(riv,index(:,8),'>','b'); hold on
scatter(riv,index(:,11),'<','m'); hold on
scatter(riv,index(:,14),'x','m');
set(gca,'XTick',[1:15]);
set(gca,'YTick',[-1:.5:1]);
set(gca,'xticklabel',{[]})
set(gca,'YLim',[-1 1],'XLim',[.5 15.5]);
ylabel('KGE');
grid on
box on
%% PDR
subplot(3,1,3)
scatter(riv,index(:,3),'o','r'); hold on
scatter(riv,index(:,6),'*','g');  hold on
scatter(riv,index(:,9),'>','b'); hold on
scatter(riv,index(:,12),'<','m'); hold on
scatter(riv,index(:,15),'x','k');
set(gca,'XTick',[1:15]);
set(gca,'YTick',[0:4]);
%set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D'});
set(gca,'YLim',[0 4],'XLim',[.5 15.5]);
ylabel('PDR');
xlabel('Station number');
grid on
box on

% print('index.jpg', '-dpng', '-r600');