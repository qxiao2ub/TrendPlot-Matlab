%----read and sum test case 12----
clear;clc;close all;

t=[1:40];



% -----------plot VIII to IX (4-1 plot and 2-2 plot: std vs std): (4*1 plot) compare std. pricing & optimal pricing plot d, D, E, D/d for 40 time periods-121120-----------
for h=1:40
    fileName=['Period',num2str(h-1),'.txt'];
    a=load(fileName);
    d(:,:,h)=a;
    s(h,1)=sum(sum(a));
  
    fileName1=['Opt.Ddratio',num2str(h),'_112620.txt']; %txt: Period 1 to 40
    read1=load(fileName1); %load that txt
    Ddra_opt(:,:,h)=read1; %assign txt to dijt
    
    fileName11=['stdPricing_Ddra=',num2str(h),'_121320.txt']; %txt: Period 1 to 40
    read11=load(fileName11); %load that txt
    Ddra_std(:,:,h)=read11; %assign txt to dijt
    
    fileName2=['3Iter_Pijt=',num2str(h),'_112720.txt']; %txt: Period 1 to 40
    read2=load(fileName2); %load that txt
    P_opt(:,:,h)=read2; %assign txt to dijt
    
    fileName22=['stdPricing_Pijt=',num2str(h),'_121320.txt']; %txt: Period 1 to 40
    read22=load(fileName22); %load that txt
    P_std(:,:,h)=read22; %assign txt to dijt
    
    fileName3=['3Iter_Eijt=',num2str(h),'_120520.txt']; %txt: Period 1 to 40
    read3=load(fileName3); %load that txt
    Eijt_opt_ori(:,:,h)=read3; %assign txt to dijt
    
    fileName33=['stdPricing_Eijt=',num2str(h),'_121320.txt']; %txt: Period 1 to 40
    read33=load(fileName33); %load that txt
    Eijt_std_ori(:,:,h)=read33; %assign txt to dijt
end

for i_1=1:20
  for j_1=1:20
    for t_1=1:40
      if Eijt_opt_ori(i_1,j_1,t_1) < 0
          Eijt_opt_adj(i_1,j_1,t_1) = 0;
      elseif Eijt_opt_ori(i_1,j_1,t_1) >= 0
          Eijt_opt_adj(i_1,j_1,t_1) = Eijt_opt_ori(i_1,j_1,t_1);
      end
      
      if Eijt_std_ori(i_1,j_1,t_1) < 0
          Eijt_std_adj(i_1,j_1,t_1) = 0;
      elseif Eijt_std_ori(i_1,j_1,t_1) >= 0
          Eijt_std_adj(i_1,j_1,t_1) = Eijt_std_ori(i_1,j_1,t_1);
      end
      
    end
  end
end

for t1=1:40
  Ddra_opt_avg(t1) = sum(sum(Ddra_opt(1:20,1:20,t1)))./400;
  Ddra_std_avg(t1) = sum(sum(Ddra_std(1:20,1:20,t1)))./400;
  P_opt_avg(t1) = sum(sum(P_opt(1:20,1:20,t1)))./400;
  P_std_avg(t1) = sum(sum(P_std(1:20,1:20,t1)))./400;
  Eijt_opt_adj_avg(t1) = sum(sum(Eijt_opt_adj(1:20,1:20,t1)))./400;
  Eijt_std_adj_avg(t1) = sum(sum(Eijt_std_adj(1:20,1:20,t1)))./400;
end

y2=[s(1,1) s(2,1) s(3,1) s(4,1) s(5,1) s(6,1) s(7,1) s(8,1) s(9,1) s(10,1) s(11,1) s(12,1) s(13,1) s(14,1) s(15,1) s(16,1) s(17,1) s(18,1) s(19,1) s(20,1) s(21,1) s(22,1) s(23,1) s(24,1) s(25,1) s(26,1) s(27,1) s(28,1) s(29,1) s(30,1) s(31,1) s(32,1) s(33,1) s(34,1) s(35,1) s(36,1) s(37,1) s(38,1) s(39,1) s(40,1)];

figure(4);
tiledlayout(4,1); % subplots layout

% 1st dijt subplot
nexttile;
p=polyfit(t,y2,10); %10-fit by a tenth polynomial
y2=polyval(p,t);
plot(t,y2);
grid on; %add grid
xlabel('Time Period');
ylabel('dijt');
title('Total demand dijt');
% set(gca,'ylim',[80000,260000]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'}); % set x-axis name


% 2nd D/d SAV covered demand ratio subplot
nexttile;
plot(t,Ddra_opt_avg,t,Ddra_std_avg);
grid on; %add grid
xlabel('Time Period');
ylabel('D/d');
title('SAV Covered Demand Ratio (D/d)');
% set(gca,'ylim',[.94,.97]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});
legend('Optimal','Std. Pricing');

% 3rd optimal pricing P_opt subplot
nexttile;
plot(t,P_opt_avg,t,P_std_avg);
grid on; %add grid
xlabel('Time Period');
ylabel('Optimal Pricing $/hr');
title('Optimal Pricing $/hr');
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});
legend('Optimal','Std. Pricing');

% 4th Empty trip Eijt subplot
nexttile;
plot(t,Eijt_opt_adj_avg,t,Eijt_std_adj_avg);
grid on; %add grid
xlabel('Time Period');
ylabel('Empty Trip');
title('Empty Trip Eijt');
set(gca,'ylim',[-1,23]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});

% -----------plot VIII: (2*2 plot) compare std. pricing & optimal pricing plot d, D, E, D/d for 40 time periods-121120-----------
%{

i1=1;
j2=8;

% 1 to 8-opt
d_2_seri = [d(i1,j2,1)  d(i1,j2,2)  d(i1,j2,3)  d(i1,j2,4)  d(i1,j2,5)  d(i1,j2,6)  d(i1,j2,7)  d(i1,j2,8)  d(i1,j2,9)  d(i1,j2,10)...
          d(i1,j2,11)  d(i1,j2,12)  d(i1,j2,13)  d(i1,j2,14)  d(i1,j2,15)  d(i1,j2,16)  d(i1,j2,17)  d(i1,j2,18)  d(i1,j2,19)  d(i1,j2,20)...
          d(i1,j2,21)  d(i1,j2,22)  d(i1,j2,23)  d(i1,j2,24)  d(i1,j2,25)  d(i1,j2,26)  d(i1,j2,27)  d(i1,j2,28)  d(i1,j2,29)  d(i1,j2,30)...
          d(i1,j2,31)  d(i1,j2,32)  d(i1,j2,33)  d(i1,j2,34)  d(i1,j2,35)  d(i1,j2,36)  d(i1,j2,37)  d(i1,j2,38)  d(i1,j2,39)  d(i1,j2,40)];

Ddra_opt_2_seri = [Ddra_opt(i1,j2,1)  Ddra_opt(i1,j2,2)  Ddra_opt(i1,j2,3)  Ddra_opt(i1,j2,4)  Ddra_opt(i1,j2,5)  Ddra_opt(i1,j2,6)  Ddra_opt(i1,j2,7)  Ddra_opt(i1,j2,8)  Ddra_opt(i1,j2,9)  Ddra_opt(i1,j2,10)...
          Ddra_opt(i1,j2,11)  Ddra_opt(i1,j2,12)  Ddra_opt(i1,j2,13)  Ddra_opt(i1,j2,14)  Ddra_opt(i1,j2,15)  Ddra_opt(i1,j2,16)  Ddra_opt(i1,j2,17)  Ddra_opt(i1,j2,18)  Ddra_opt(i1,j2,19)  Ddra_opt(i1,j2,20)...
          Ddra_opt(i1,j2,21)  Ddra_opt(i1,j2,22)  Ddra_opt(i1,j2,23)  Ddra_opt(i1,j2,24)  Ddra_opt(i1,j2,25)  Ddra_opt(i1,j2,26)  Ddra_opt(i1,j2,27)  Ddra_opt(i1,j2,28)  Ddra_opt(i1,j2,29)  Ddra_opt(i1,j2,30)...
          Ddra_opt(i1,j2,31)  Ddra_opt(i1,j2,32)  Ddra_opt(i1,j2,33)  Ddra_opt(i1,j2,34)  Ddra_opt(i1,j2,35)  Ddra_opt(i1,j2,36)  Ddra_opt(i1,j2,37)  Ddra_opt(i1,j2,38)  Ddra_opt(i1,j2,39)  Ddra_opt(i1,j2,40)];        

P_opt_2_seri = [P_opt(i1,j2,1)  P_opt(i1,j2,2)  P_opt(i1,j2,3)  P_opt(i1,j2,4)  P_opt(i1,j2,5)  P_opt(i1,j2,6)  P_opt(i1,j2,7)  P_opt(i1,j2,8)  P_opt(i1,j2,9)  P_opt(i1,j2,10)...
          P_opt(i1,j2,11)  P_opt(i1,j2,12)  P_opt(i1,j2,13)  P_opt(i1,j2,14)  P_opt(i1,j2,15)  P_opt(i1,j2,16)  P_opt(i1,j2,17)  P_opt(i1,j2,18)  P_opt(i1,j2,19)  P_opt(i1,j2,20)...
          P_opt(i1,j2,21)  P_opt(i1,j2,22)  P_opt(i1,j2,23)  P_opt(i1,j2,24)  P_opt(i1,j2,25)  P_opt(i1,j2,26)  P_opt(i1,j2,27)  P_opt(i1,j2,28)  P_opt(i1,j2,29)  P_opt(i1,j2,30)...
          P_opt(i1,j2,31)  P_opt(i1,j2,32)  P_opt(i1,j2,33)  P_opt(i1,j2,34)  P_opt(i1,j2,35)  P_opt(i1,j2,36)  P_opt(i1,j2,37)  P_opt(i1,j2,38)  P_opt(i1,j2,39)  P_opt(i1,j2,40)];

Eijt_opt_adj_2_seri = [Eijt_opt_adj(i1,j2,1)  Eijt_opt_adj(i1,j2,2)  Eijt_opt_adj(i1,j2,3)  Eijt_opt_adj(i1,j2,4)  Eijt_opt_adj(i1,j2,5)  Eijt_opt_adj(i1,j2,6)  Eijt_opt_adj(i1,j2,7)  Eijt_opt_adj(i1,j2,8)  Eijt_opt_adj(i1,j2,9)  Eijt_opt_adj(i1,j2,10)...
          Eijt_opt_adj(i1,j2,11)  Eijt_opt_adj(i1,j2,12)  Eijt_opt_adj(i1,j2,13)  Eijt_opt_adj(i1,j2,14)  Eijt_opt_adj(i1,j2,15)  Eijt_opt_adj(i1,j2,16)  Eijt_opt_adj(i1,j2,17)  Eijt_opt_adj(i1,j2,18)  Eijt_opt_adj(i1,j2,19)  Eijt_opt_adj(i1,j2,20)...
          Eijt_opt_adj(i1,j2,21)  Eijt_opt_adj(i1,j2,22)  Eijt_opt_adj(i1,j2,23)  Eijt_opt_adj(i1,j2,24)  Eijt_opt_adj(i1,j2,25)  Eijt_opt_adj(i1,j2,26)  Eijt_opt_adj(i1,j2,27)  Eijt_opt_adj(i1,j2,28)  Eijt_opt_adj(i1,j2,29)  Eijt_opt_adj(i1,j2,30)...
          Eijt_opt_adj(i1,j2,31)  Eijt_opt_adj(i1,j2,32)  Eijt_opt_adj(i1,j2,33)  Eijt_opt_adj(i1,j2,34)  Eijt_opt_adj(i1,j2,35)  Eijt_opt_adj(i1,j2,36)  Eijt_opt_adj(i1,j2,37)  Eijt_opt_adj(i1,j2,38)  Eijt_opt_adj(i1,j2,39)  Eijt_opt_adj(i1,j2,40)];         

% 1 to 8-std
Ddra_std_2_seri = [Ddra_std(i1,j2,1)  Ddra_std(i1,j2,2)  Ddra_std(i1,j2,3)  Ddra_std(i1,j2,4)  Ddra_std(i1,j2,5)  Ddra_std(i1,j2,6)  Ddra_std(i1,j2,7)  Ddra_std(i1,j2,8)  Ddra_std(i1,j2,9)  Ddra_std(i1,j2,10)...
          Ddra_std(i1,j2,11)  Ddra_std(i1,j2,12)  Ddra_std(i1,j2,13)  Ddra_std(i1,j2,14)  Ddra_std(i1,j2,15)  Ddra_std(i1,j2,16)  Ddra_std(i1,j2,17)  Ddra_std(i1,j2,18)  Ddra_std(i1,j2,19)  Ddra_std(i1,j2,20)...
          Ddra_std(i1,j2,21)  Ddra_std(i1,j2,22)  Ddra_std(i1,j2,23)  Ddra_std(i1,j2,24)  Ddra_std(i1,j2,25)  Ddra_std(i1,j2,26)  Ddra_std(i1,j2,27)  Ddra_std(i1,j2,28)  Ddra_std(i1,j2,29)  Ddra_std(i1,j2,30)...
          Ddra_std(i1,j2,31)  Ddra_std(i1,j2,32)  Ddra_std(i1,j2,33)  Ddra_std(i1,j2,34)  Ddra_std(i1,j2,35)  Ddra_std(i1,j2,36)  Ddra_std(i1,j2,37)  Ddra_std(i1,j2,38)  Ddra_std(i1,j2,39)  Ddra_std(i1,j2,40)];        

P_std_2_seri = [P_std(i1,j2,1)  P_std(i1,j2,2)  P_std(i1,j2,3)  P_std(i1,j2,4)  P_std(i1,j2,5)  P_std(i1,j2,6)  P_std(i1,j2,7)  P_std(i1,j2,8)  P_std(i1,j2,9)  P_std(i1,j2,10)...
          P_std(i1,j2,11)  P_std(i1,j2,12)  P_std(i1,j2,13)  P_std(i1,j2,14)  P_std(i1,j2,15)  P_std(i1,j2,16)  P_std(i1,j2,17)  P_std(i1,j2,18)  P_std(i1,j2,19)  P_std(i1,j2,20)...
          P_std(i1,j2,21)  P_std(i1,j2,22)  P_std(i1,j2,23)  P_std(i1,j2,24)  P_std(i1,j2,25)  P_std(i1,j2,26)  P_std(i1,j2,27)  P_std(i1,j2,28)  P_std(i1,j2,29)  P_std(i1,j2,30)...
          P_std(i1,j2,31)  P_std(i1,j2,32)  P_std(i1,j2,33)  P_std(i1,j2,34)  P_std(i1,j2,35)  P_std(i1,j2,36)  P_std(i1,j2,37)  P_std(i1,j2,38)  P_std(i1,j2,39)  P_std(i1,j2,40)];

Eijt_std_adj_2_seri = [Eijt_std_adj(i1,j2,1)  Eijt_std_adj(i1,j2,2)  Eijt_std_adj(i1,j2,3)  Eijt_std_adj(i1,j2,4)  Eijt_std_adj(i1,j2,5)  Eijt_std_adj(i1,j2,6)  Eijt_std_adj(i1,j2,7)  Eijt_std_adj(i1,j2,8)  Eijt_std_adj(i1,j2,9)  Eijt_std_adj(i1,j2,10)...
          Eijt_std_adj(i1,j2,11)  Eijt_std_adj(i1,j2,12)  Eijt_std_adj(i1,j2,13)  Eijt_std_adj(i1,j2,14)  Eijt_std_adj(i1,j2,15)  Eijt_std_adj(i1,j2,16)  Eijt_std_adj(i1,j2,17)  Eijt_std_adj(i1,j2,18)  Eijt_std_adj(i1,j2,19)  Eijt_std_adj(i1,j2,20)...
          Eijt_std_adj(i1,j2,21)  Eijt_std_adj(i1,j2,22)  Eijt_std_adj(i1,j2,23)  Eijt_std_adj(i1,j2,24)  Eijt_std_adj(i1,j2,25)  Eijt_std_adj(i1,j2,26)  Eijt_std_adj(i1,j2,27)  Eijt_std_adj(i1,j2,28)  Eijt_std_adj(i1,j2,29)  Eijt_std_adj(i1,j2,30)...
          Eijt_std_adj(i1,j2,31)  Eijt_std_adj(i1,j2,32)  Eijt_std_adj(i1,j2,33)  Eijt_std_adj(i1,j2,34)  Eijt_std_adj(i1,j2,35)  Eijt_std_adj(i1,j2,36)  Eijt_std_adj(i1,j2,37)  Eijt_std_adj(i1,j2,38)  Eijt_std_adj(i1,j2,39)  Eijt_std_adj(i1,j2,40)];         

figure(5);        
tiledlayout(2,2); % subplots layout        
        
% %{
% 1st dijt subplot for particular i,j pair
nexttile;
% p=polyfit(t,y2,6); %10-fit by a tenth polynomial
% y2=polyval(p,t);
plot(t,d_2_seri);
grid on; %add grid
xlabel('Time Period');
ylabel('dijt');
title('Total demand dijt (i=1 to j=8)');
% set(gca,'ylim',[80000,260000]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'}); % set x-axis name

% 2nd D/d SAV covered demand ratio subplot
nexttile;
plot(t,Ddra_opt_2_seri,t,Ddra_std_2_seri);
grid on; %add grid
xlabel('Time Period');
ylabel('D/d');
title('SAV Covered Demand Ratio (D/d) (i=1 to j=8)');
% set(gca,'ylim',[.94,.97]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});
legend('optimal','std. Pricing');

% 3rd optimal pricing P_opt subplot
nexttile;
plot(t,P_opt_2_seri,t,P_std_2_seri);
grid on; %add grid
xlabel('Time Period');
ylabel('Optimal Pricing $/hr');
title('Optimal Pricing $/hr (i=1 to j=8)');
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});
legend('optimal','std. Pricing');

% 4th Empty trip Eijt subplot
nexttile;
plot(t,Eijt_opt_adj_2_seri,t,Eijt_std_adj_2_seri);
grid on; %add grid
xlabel('Time Period');
ylabel('Empty Trip');
title('Empty Trip Eijt (i=1 to j=8)');
% set(gca,'ylim',[-1,23]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});
legend('optimal','std. Pricing');
%}        
        
% -----------plot V to VII: 3 pairs Combination plot d, D, E, D/d for 40 time periods (single i,j pair)-121120-----------
%{
for h=1:40
    fileName=['Period',num2str(h-1),'.txt'];
    read=load(fileName);
    d(:,:,h)=read;
    
    fileName1=['Opt.Ddratio',num2str(h),'_112620.txt']; %txt: Period 1 to 40
    read1=load(fileName1); %load that txt
    Ddra(:,:,h)=read1; %assign txt to dijt
    
    fileName2=['3Iter_Pijt=',num2str(h),'_112720.txt']; %txt: Period 1 to 40
    read2=load(fileName2); %load that txt
    P_opt(:,:,h)=read2; %assign txt to dijt
    
    fileName3=['3Iter_Eijt=',num2str(h),'_120520.txt']; %txt: Period 1 to 40
    read3=load(fileName3); %load that txt
    Eijt_ori(:,:,h)=read3; %assign txt to dijt
end

% tiledlayout(4,1); % subplots layout

i1=1;
j1=2;
j2=8;
i3=19;
j3=10;

for i_1=1:20
  for j_1=1:20
    for t_1=1:40
      if Eijt_ori(i_1,j_1,t_1) < 0
          Eijt_adj(i_1,j_1,t_1) = 0;
      elseif Eijt_ori(i_1,j_1,t_1) >= 0
          Eijt_adj(i_1,j_1,t_1) = Eijt_ori(i_1,j_1,t_1);
      end
    end
  end
end

% 1 to 2
d_1_seri = [d(i1,j1,1)  d(i1,j1,2)  d(i1,j1,3)  d(i1,j1,4)  d(i1,j1,5)  d(i1,j1,6)  d(i1,j1,7)  d(i1,j1,8)  d(i1,j1,9)  d(i1,j1,10)...
          d(i1,j1,11)  d(i1,j1,12)  d(i1,j1,13)  d(i1,j1,14)  d(i1,j1,15)  d(i1,j1,16)  d(i1,j1,17)  d(i1,j1,18)  d(i1,j1,19)  d(i1,j1,20)...
          d(i1,j1,21)  d(i1,j1,22)  d(i1,j1,23)  d(i1,j1,24)  d(i1,j1,25)  d(i1,j1,26)  d(i1,j1,27)  d(i1,j1,28)  d(i1,j1,29)  d(i1,j1,30)...
          d(i1,j1,31)  d(i1,j1,32)  d(i1,j1,33)  d(i1,j1,34)  d(i1,j1,35)  d(i1,j1,36)  d(i1,j1,37)  d(i1,j1,38)  d(i1,j1,39)  d(i1,j1,40)];

Ddra_1_seri = [Ddra(i1,j1,1)  Ddra(i1,j1,2)  Ddra(i1,j1,3)  Ddra(i1,j1,4)  Ddra(i1,j1,5)  Ddra(i1,j1,6)  Ddra(i1,j1,7)  Ddra(i1,j1,8)  Ddra(i1,j1,9)  Ddra(i1,j1,10)...
          Ddra(i1,j1,11)  Ddra(i1,j1,12)  Ddra(i1,j1,13)  Ddra(i1,j1,14)  Ddra(i1,j1,15)  Ddra(i1,j1,16)  Ddra(i1,j1,17)  Ddra(i1,j1,18)  Ddra(i1,j1,19)  Ddra(i1,j1,20)...
          Ddra(i1,j1,21)  Ddra(i1,j1,22)  Ddra(i1,j1,23)  Ddra(i1,j1,24)  Ddra(i1,j1,25)  Ddra(i1,j1,26)  Ddra(i1,j1,27)  Ddra(i1,j1,28)  Ddra(i1,j1,29)  Ddra(i1,j1,30)...
          Ddra(i1,j1,31)  Ddra(i1,j1,32)  Ddra(i1,j1,33)  Ddra(i1,j1,34)  Ddra(i1,j1,35)  Ddra(i1,j1,36)  Ddra(i1,j1,37)  Ddra(i1,j1,38)  Ddra(i1,j1,39)  Ddra(i1,j1,40)];        

P_opt_1_seri = [P_opt(i1,j1,1)  P_opt(i1,j1,2)  P_opt(i1,j1,3)  P_opt(i1,j1,4)  P_opt(i1,j1,5)  P_opt(i1,j1,6)  P_opt(i1,j1,7)  P_opt(i1,j1,8)  P_opt(i1,j1,9)  P_opt(i1,j1,10)...
          P_opt(i1,j1,11)  P_opt(i1,j1,12)  P_opt(i1,j1,13)  P_opt(i1,j1,14)  P_opt(i1,j1,15)  P_opt(i1,j1,16)  P_opt(i1,j1,17)  P_opt(i1,j1,18)  P_opt(i1,j1,19)  P_opt(i1,j1,20)...
          P_opt(i1,j1,21)  P_opt(i1,j1,22)  P_opt(i1,j1,23)  P_opt(i1,j1,24)  P_opt(i1,j1,25)  P_opt(i1,j1,26)  P_opt(i1,j1,27)  P_opt(i1,j1,28)  P_opt(i1,j1,29)  P_opt(i1,j1,30)...
          P_opt(i1,j1,31)  P_opt(i1,j1,32)  P_opt(i1,j1,33)  P_opt(i1,j1,34)  P_opt(i1,j1,35)  P_opt(i1,j1,36)  P_opt(i1,j1,37)  P_opt(i1,j1,38)  P_opt(i1,j1,39)  P_opt(i1,j1,40)];

Eijt_adj_1_seri = [Eijt_adj(i1,j1,1)  Eijt_adj(i1,j1,2)  Eijt_adj(i1,j1,3)  Eijt_adj(i1,j1,4)  Eijt_adj(i1,j1,5)  Eijt_adj(i1,j1,6)  Eijt_adj(i1,j1,7)  Eijt_adj(i1,j1,8)  Eijt_adj(i1,j1,9)  Eijt_adj(i1,j1,10)...
          Eijt_adj(i1,j1,11)  Eijt_adj(i1,j1,12)  Eijt_adj(i1,j1,13)  Eijt_adj(i1,j1,14)  Eijt_adj(i1,j1,15)  Eijt_adj(i1,j1,16)  Eijt_adj(i1,j1,17)  Eijt_adj(i1,j1,18)  Eijt_adj(i1,j1,19)  Eijt_adj(i1,j1,20)...
          Eijt_adj(i1,j1,21)  Eijt_adj(i1,j1,22)  Eijt_adj(i1,j1,23)  Eijt_adj(i1,j1,24)  Eijt_adj(i1,j1,25)  Eijt_adj(i1,j1,26)  Eijt_adj(i1,j1,27)  Eijt_adj(i1,j1,28)  Eijt_adj(i1,j1,29)  Eijt_adj(i1,j1,30)...
          Eijt_adj(i1,j1,31)  Eijt_adj(i1,j1,32)  Eijt_adj(i1,j1,33)  Eijt_adj(i1,j1,34)  Eijt_adj(i1,j1,35)  Eijt_adj(i1,j1,36)  Eijt_adj(i1,j1,37)  Eijt_adj(i1,j1,38)  Eijt_adj(i1,j1,39)  Eijt_adj(i1,j1,40)];        

% 1 to 8        
d_2_seri = [d(i1,j2,1)  d(i1,j2,2)  d(i1,j2,3)  d(i1,j2,4)  d(i1,j2,5)  d(i1,j2,6)  d(i1,j2,7)  d(i1,j2,8)  d(i1,j2,9)  d(i1,j2,10)...
          d(i1,j2,11)  d(i1,j2,12)  d(i1,j2,13)  d(i1,j2,14)  d(i1,j2,15)  d(i1,j2,16)  d(i1,j2,17)  d(i1,j2,18)  d(i1,j2,19)  d(i1,j2,20)...
          d(i1,j2,21)  d(i1,j2,22)  d(i1,j2,23)  d(i1,j2,24)  d(i1,j2,25)  d(i1,j2,26)  d(i1,j2,27)  d(i1,j2,28)  d(i1,j2,29)  d(i1,j2,30)...
          d(i1,j2,31)  d(i1,j2,32)  d(i1,j2,33)  d(i1,j2,34)  d(i1,j2,35)  d(i1,j2,36)  d(i1,j2,37)  d(i1,j2,38)  d(i1,j2,39)  d(i1,j2,40)];

Ddra_2_seri = [Ddra(i1,j2,1)  Ddra(i1,j2,2)  Ddra(i1,j2,3)  Ddra(i1,j2,4)  Ddra(i1,j2,5)  Ddra(i1,j2,6)  Ddra(i1,j2,7)  Ddra(i1,j2,8)  Ddra(i1,j2,9)  Ddra(i1,j2,10)...
          Ddra(i1,j2,11)  Ddra(i1,j2,12)  Ddra(i1,j2,13)  Ddra(i1,j2,14)  Ddra(i1,j2,15)  Ddra(i1,j2,16)  Ddra(i1,j2,17)  Ddra(i1,j2,18)  Ddra(i1,j2,19)  Ddra(i1,j2,20)...
          Ddra(i1,j2,21)  Ddra(i1,j2,22)  Ddra(i1,j2,23)  Ddra(i1,j2,24)  Ddra(i1,j2,25)  Ddra(i1,j2,26)  Ddra(i1,j2,27)  Ddra(i1,j2,28)  Ddra(i1,j2,29)  Ddra(i1,j2,30)...
          Ddra(i1,j2,31)  Ddra(i1,j2,32)  Ddra(i1,j2,33)  Ddra(i1,j2,34)  Ddra(i1,j2,35)  Ddra(i1,j2,36)  Ddra(i1,j2,37)  Ddra(i1,j2,38)  Ddra(i1,j2,39)  Ddra(i1,j2,40)];        

P_opt_2_seri = [P_opt(i1,j2,1)  P_opt(i1,j2,2)  P_opt(i1,j2,3)  P_opt(i1,j2,4)  P_opt(i1,j2,5)  P_opt(i1,j2,6)  P_opt(i1,j2,7)  P_opt(i1,j2,8)  P_opt(i1,j2,9)  P_opt(i1,j2,10)...
          P_opt(i1,j2,11)  P_opt(i1,j2,12)  P_opt(i1,j2,13)  P_opt(i1,j2,14)  P_opt(i1,j2,15)  P_opt(i1,j2,16)  P_opt(i1,j2,17)  P_opt(i1,j2,18)  P_opt(i1,j2,19)  P_opt(i1,j2,20)...
          P_opt(i1,j2,21)  P_opt(i1,j2,22)  P_opt(i1,j2,23)  P_opt(i1,j2,24)  P_opt(i1,j2,25)  P_opt(i1,j2,26)  P_opt(i1,j2,27)  P_opt(i1,j2,28)  P_opt(i1,j2,29)  P_opt(i1,j2,30)...
          P_opt(i1,j2,31)  P_opt(i1,j2,32)  P_opt(i1,j2,33)  P_opt(i1,j2,34)  P_opt(i1,j2,35)  P_opt(i1,j2,36)  P_opt(i1,j2,37)  P_opt(i1,j2,38)  P_opt(i1,j2,39)  P_opt(i1,j2,40)];

Eijt_adj_2_seri = [Eijt_adj(i1,j2,1)  Eijt_adj(i1,j2,2)  Eijt_adj(i1,j2,3)  Eijt_adj(i1,j2,4)  Eijt_adj(i1,j2,5)  Eijt_adj(i1,j2,6)  Eijt_adj(i1,j2,7)  Eijt_adj(i1,j2,8)  Eijt_adj(i1,j2,9)  Eijt_adj(i1,j2,10)...
          Eijt_adj(i1,j2,11)  Eijt_adj(i1,j2,12)  Eijt_adj(i1,j2,13)  Eijt_adj(i1,j2,14)  Eijt_adj(i1,j2,15)  Eijt_adj(i1,j2,16)  Eijt_adj(i1,j2,17)  Eijt_adj(i1,j2,18)  Eijt_adj(i1,j2,19)  Eijt_adj(i1,j2,20)...
          Eijt_adj(i1,j2,21)  Eijt_adj(i1,j2,22)  Eijt_adj(i1,j2,23)  Eijt_adj(i1,j2,24)  Eijt_adj(i1,j2,25)  Eijt_adj(i1,j2,26)  Eijt_adj(i1,j2,27)  Eijt_adj(i1,j2,28)  Eijt_adj(i1,j2,29)  Eijt_adj(i1,j2,30)...
          Eijt_adj(i1,j2,31)  Eijt_adj(i1,j2,32)  Eijt_adj(i1,j2,33)  Eijt_adj(i1,j2,34)  Eijt_adj(i1,j2,35)  Eijt_adj(i1,j2,36)  Eijt_adj(i1,j2,37)  Eijt_adj(i1,j2,38)  Eijt_adj(i1,j2,39)  Eijt_adj(i1,j2,40)];         

% 19 to 10
d_3_seri = [d(i3,j3,1)  d(i3,j3,2)  d(i3,j3,3)  d(i3,j3,4)  d(i3,j3,5)  d(i3,j3,6)  d(i3,j3,7)  d(i3,j3,8)  d(i3,j3,9)  d(i3,j3,10)...
          d(i3,j3,11)  d(i3,j3,12)  d(i3,j3,13)  d(i3,j3,14)  d(i3,j3,15)  d(i3,j3,16)  d(i3,j3,17)  d(i3,j3,18)  d(i3,j3,19)  d(i3,j3,20)...
          d(i3,j3,21)  d(i3,j3,22)  d(i3,j3,23)  d(i3,j3,24)  d(i3,j3,25)  d(i3,j3,26)  d(i3,j3,27)  d(i3,j3,28)  d(i3,j3,29)  d(i3,j3,30)...
          d(i3,j3,31)  d(i3,j3,32)  d(i3,j3,33)  d(i3,j3,34)  d(i3,j3,35)  d(i3,j3,36)  d(i3,j3,37)  d(i3,j3,38)  d(i3,j3,39)  d(i3,j3,40)];

Ddra_3_seri = [Ddra(i3,j3,1)  Ddra(i3,j3,2)  Ddra(i3,j3,3)  Ddra(i3,j3,4)  Ddra(i3,j3,5)  Ddra(i3,j3,6)  Ddra(i3,j3,7)  Ddra(i3,j3,8)  Ddra(i3,j3,9)  Ddra(i3,j3,10)...
          Ddra(i3,j3,11)  Ddra(i3,j3,12)  Ddra(i3,j3,13)  Ddra(i3,j3,14)  Ddra(i3,j3,15)  Ddra(i3,j3,16)  Ddra(i3,j3,17)  Ddra(i3,j3,18)  Ddra(i3,j3,19)  Ddra(i3,j3,20)...
          Ddra(i3,j3,21)  Ddra(i3,j3,22)  Ddra(i3,j3,23)  Ddra(i3,j3,24)  Ddra(i3,j3,25)  Ddra(i3,j3,26)  Ddra(i3,j3,27)  Ddra(i3,j3,28)  Ddra(i3,j3,29)  Ddra(i3,j3,30)...
          Ddra(i3,j3,31)  Ddra(i3,j3,32)  Ddra(i3,j3,33)  Ddra(i3,j3,34)  Ddra(i3,j3,35)  Ddra(i3,j3,36)  Ddra(i3,j3,37)  Ddra(i3,j3,38)  Ddra(i3,j3,39)  Ddra(i3,j3,40)];        

P_opt_3_seri = [P_opt(i3,j3,1)  P_opt(i3,j3,2)  P_opt(i3,j3,3)  P_opt(i3,j3,4)  P_opt(i3,j3,5)  P_opt(i3,j3,6)  P_opt(i3,j3,7)  P_opt(i3,j3,8)  P_opt(i3,j3,9)  P_opt(i3,j3,10)...
          P_opt(i3,j3,11)  P_opt(i3,j3,12)  P_opt(i3,j3,13)  P_opt(i3,j3,14)  P_opt(i3,j3,15)  P_opt(i3,j3,16)  P_opt(i3,j3,17)  P_opt(i3,j3,18)  P_opt(i3,j3,19)  P_opt(i3,j3,20)...
          P_opt(i3,j3,21)  P_opt(i3,j3,22)  P_opt(i3,j3,23)  P_opt(i3,j3,24)  P_opt(i3,j3,25)  P_opt(i3,j3,26)  P_opt(i3,j3,27)  P_opt(i3,j3,28)  P_opt(i3,j3,29)  P_opt(i3,j3,30)...
          P_opt(i3,j3,31)  P_opt(i3,j3,32)  P_opt(i3,j3,33)  P_opt(i3,j3,34)  P_opt(i3,j3,35)  P_opt(i3,j3,36)  P_opt(i3,j3,37)  P_opt(i3,j3,38)  P_opt(i3,j3,39)  P_opt(i3,j3,40)];

Eijt_adj_3_seri = [Eijt_adj(i3,j3,1)  Eijt_adj(i3,j3,2)  Eijt_adj(i3,j3,3)  Eijt_adj(i3,j3,4)  Eijt_adj(i3,j3,5)  Eijt_adj(i3,j3,6)  Eijt_adj(i3,j3,7)  Eijt_adj(i3,j3,8)  Eijt_adj(i3,j3,9)  Eijt_adj(i3,j3,10)...
          Eijt_adj(i3,j3,11)  Eijt_adj(i3,j3,12)  Eijt_adj(i3,j3,13)  Eijt_adj(i3,j3,14)  Eijt_adj(i3,j3,15)  Eijt_adj(i3,j3,16)  Eijt_adj(i3,j3,17)  Eijt_adj(i3,j3,18)  Eijt_adj(i3,j3,19)  Eijt_adj(i3,j3,20)...
          Eijt_adj(i3,j3,21)  Eijt_adj(i3,j3,22)  Eijt_adj(i3,j3,23)  Eijt_adj(i3,j3,24)  Eijt_adj(i3,j3,25)  Eijt_adj(i3,j3,26)  Eijt_adj(i3,j3,27)  Eijt_adj(i3,j3,28)  Eijt_adj(i3,j3,29)  Eijt_adj(i3,j3,30)...
          Eijt_adj(i3,j3,31)  Eijt_adj(i3,j3,32)  Eijt_adj(i3,j3,33)  Eijt_adj(i3,j3,34)  Eijt_adj(i3,j3,35)  Eijt_adj(i3,j3,36)  Eijt_adj(i3,j3,37)  Eijt_adj(i3,j3,38)  Eijt_adj(i3,j3,39)  Eijt_adj(i3,j3,40)]; 

figure(3);        
tiledlayout(2,2); % subplots layout        
        
% %{
% 1st dijt subplot for particular i,j pair
nexttile;
% p=polyfit(t,y2,6); %10-fit by a tenth polynomial
% y2=polyval(p,t);
plot(t,d_1_seri,t,d_2_seri,t,d_3_seri);
grid on; %add grid
xlabel('Time Period');
ylabel('dijt');
title('Total demand dijt');
% set(gca,'ylim',[80000,260000]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'}); % set x-axis name
legend('i=1 to j=2','i=1 to j=8','i=19 to j=10');
% %}

% 2nd D/d SAV covered demand ratio subplot
nexttile;
plot(t,Ddra_1_seri,t,Ddra_2_seri,t,Ddra_3_seri);
grid on; %add grid
xlabel('Time Period');
ylabel('D/d');
title('SAV Covered Demand Ratio (D/d)');
% set(gca,'ylim',[.94,.97]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});
legend('i=1 to j=2','i=1 to j=8','i=19 to j=10');

% 3rd optimal pricing P_opt subplot
nexttile;
plot(t,P_opt_1_seri,t,P_opt_2_seri,t,P_opt_3_seri);
grid on; %add grid
xlabel('Time Period');
ylabel('Optimal Pricing $/hr');
title('Optimal Pricing $/hr');
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});
legend('i=1 to j=2','i=1 to j=8','i=19 to j=10');

% 4th Empty trip Eijt subplot
nexttile;
plot(t,Eijt_adj_1_seri,t,Eijt_adj_2_seri,t,Eijt_adj_3_seri);
grid on; %add grid
xlabel('Time Period');
ylabel('Empty Trip');
title('Empty Trip Eijt');
% set(gca,'ylim',[-1,23]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});
legend('i=1 to j=2','i=1 to j=8','i=19 to j=10');

% -----------plot VI: Only 1 pair of Combination plot d, D, E, D/d for 40 time periods (single i,j pair)-121120-----------

figure(2);        
tiledlayout(2,2); % subplots layout        
        
% %{
% 1st dijt subplot for particular i,j pair
nexttile;
% p=polyfit(t,y2,6); %10-fit by a tenth polynomial
% y2=polyval(p,t);
plot(t,d_1_seri);
grid on; %add grid
xlabel('Time Period');
ylabel('dijt');
title('Total demand dijt');
% set(gca,'ylim',[80000,260000]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'}); % set x-axis name

% %}

% 2nd D/d SAV covered demand ratio subplot
nexttile;
plot(t,Ddra_1_seri,'m');
grid on; %add grid
xlabel('Time Period');
ylabel('D/d');
title('SAV Covered Demand Ratio (D/d)');
% set(gca,'ylim',[.94,.97]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});


% 3rd optimal pricing P_opt subplot
nexttile;
plot(t,P_opt_1_seri,'c');
grid on; %add grid
xlabel('Time Period');
ylabel('Optimal Pricing $/hr');
title('Optimal Pricing $/hr');
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});


% 4th Empty trip Eijt subplot
nexttile;
plot(t,Eijt_adj_1_seri,'b');
grid on; %add grid
xlabel('Time Period');
ylabel('Empty Trip');
title('Empty Trip Eijt');
% set(gca,'ylim',[-1,23]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});


% -----------plot V: Combination plot d, D, E, D/d for 40 time periods-121120-----------
% %{
for h=1:40
    fileName=['Period',num2str(h-1),'.txt'];
    a=load(fileName);
    s(h,1)=sum(sum(a));
    
    fileName1=['Opt.Ddratio',num2str(h),'_112620.txt']; %txt: Period 1 to 40
    read1=load(fileName1); %load that txt
    Ddra(:,:,h)=read1; %assign txt to dijt
    
    fileName2=['3Iter_Pijt=',num2str(h),'_112720.txt']; %txt: Period 1 to 40
    read2=load(fileName2); %load that txt
    P_opt(:,:,h)=read2; %assign txt to dijt
    
    fileName3=['3Iter_Eijt=',num2str(h),'_120520.txt']; %txt: Period 1 to 40
    read3=load(fileName3); %load that txt
    Eijt_ori(:,:,h)=read3; %assign txt to dijt
end

for t1=1:40
  Ddra_avg(t1) = sum(sum(Ddra(1:20,1:20,t1)))./400;
  P_opt_avg(t1) = sum(sum(P_opt(1:20,1:20,t1)))./400;
end

for i1=1:20
  for j1=1:20
    for t2=1:40
      if Eijt_ori(i1,j1,t2) < 0
          Eijt_adj(i1,j1,t2) = 0;
      elseif Eijt_ori(i1,j1,t2) >= 0
          Eijt_adj(i1,j1,t2) = Eijt_ori(i1,j1,t2);
      end
    end
  end
end

for t3=1:40
  Eijt_adj_avg(t3) = sum(sum(Eijt_adj(1:20,1:20,t3)))./400;
end

y2=[s(1,1) s(2,1) s(3,1) s(4,1) s(5,1) s(6,1) s(7,1) s(8,1) s(9,1) s(10,1) s(11,1) s(12,1) s(13,1) s(14,1) s(15,1) s(16,1) s(17,1) s(18,1) s(19,1) s(20,1) s(21,1) s(22,1) s(23,1) s(24,1) s(25,1) s(26,1) s(27,1) s(28,1) s(29,1) s(30,1) s(31,1) s(32,1) s(33,1) s(34,1) s(35,1) s(36,1) s(37,1) s(38,1) s(39,1) s(40,1)];

figure(1);
tiledlayout(4,1); % subplots layout

% 1st dijt subplot
nexttile;
p=polyfit(t,y2,10); %10-fit by a tenth polynomial
y2=polyval(p,t);
plot(t,y2);
grid on; %add grid
xlabel('Time Period');
ylabel('dijt');
title('Total demand dijt');
% set(gca,'ylim',[80000,260000]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'}); % set x-axis name


% 2nd D/d SAV covered demand ratio subplot
nexttile;
plot(t,Ddra_avg,'m');
grid on; %add grid
xlabel('Time Period');
ylabel('D/d');
title('SAV Covered Demand Ratio (D/d)');
% set(gca,'ylim',[.94,.97]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});

% 3rd optimal pricing P_opt subplot
nexttile;
plot(t,P_opt_avg,'c');
grid on; %add grid
xlabel('Time Period');
ylabel('Optimal Pricing $/hr');
title('Optimal Pricing $/hr');
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});

% 4th Empty trip Eijt subplot
nexttile;
plot(t,Eijt_adj_avg,'b');
grid on; %add grid
xlabel('Time Period');
ylabel('Empty Trip');
title('Empty Trip Eijt');
set(gca,'ylim',[-1,23]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});
%}

% -----------plot IV: Empty trip Eijt trend plot for 40 time periods-121120-----------
%{
for t3=1:40 %40 time periods
    fileName3=['3Iter_Eijt=',num2str(t3),'_120520.txt']; %txt: Period 1 to 40
    read3=load(fileName3); %load that txt
    Eijt_ori(:,:,t3)=read3; %assign txt to dijt
end

% %{ 
for i1=1:20
  for j1=1:20
    for t1=1:40
      if Eijt_ori(i1,j1,t1) < 0
          Eijt_adj(i1,j1,t1) = 0;
      elseif Eijt_ori(i1,j1,t1) >= 0
          Eijt_adj(i1,j1,t1) = Eijt_ori(i1,j1,t1);
      end
    end
  end
end

for t3=1:40
  Eijt_adj_avg(t3) = sum(sum(Eijt_adj(1:20,1:20,t3)))./400;
end

figure(4);
plot(t,Eijt_adj_avg,'b');
%{
p=polyfit(t,Eijt_adj_avg,5) %10-fit by a tenth polynomial
Eijt_adj_avg1=polyval(p,t);
plot(t,Eijt_adj_avg1,t,Eijt_adj_avg);
%}

% %{
grid on; %add grid
xlabel('Time Period');
ylabel('Empty Trip');
title('Empty Trip Eijt');
% set(gca,'ylim',[.94,.97]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});
%}


% -----------plot III: pricing P_opt trend plot for 40 time periods-121120-----------
%{
for t2=1:40 %40 time periods
    fileName2=['3Iter_Pijt=',num2str(t2),'_112720.txt']; %txt: Period 1 to 40
    read2=load(fileName2); %load that txt
    P_opt(:,:,t2)=read2; %assign txt to dijt
end

for t2=1:40
  P_opt_avg(t2) = sum(sum(P_opt(1:20,1:20,t2)))./400;
end

figure(3);
plot(t,P_opt_avg,'c');
grid on; %add grid
xlabel('Time Period');
ylabel('Optimal Pricing $/hr');
title('Optimal Pricing $/hr');
% set(gca,'ylim',[.94,.97]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});
%}

% -----------plot II: SAV_opt covered ratio D/d trend plot for 40 time periods-121120-----------
%{
for t1=1:40 %40 time periods
    fileName1=['Opt.Ddratio',num2str(t1),'_112620.txt']; %txt: Period 1 to 40
    read1=load(fileName1); %load that txt
    Ddra(:,:,t1)=read1; %assign txt to dijt
end

for t1=1:40
  Ddra_avg(t1) = sum(sum(Ddra(1:20,1:20,t1)))./400;
end

figure(2);
plot(t,Ddra_avg,'m');
grid on; %add grid
xlabel('Time Period');
ylabel('D/d');
title('SAV Covered Demand Ratio (D/d)');
set(gca,'ylim',[.94,.97]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'});
%}

% -----------plot I: dijt trend plot for 40 time periods-121120-----------
%{
n = 40; %no. of files: 40
s = zeros(n,1); %save sum to cell s
for i=1:n
    fileName=['Period',num2str(i-1),'.txt'];
    a=load(fileName);
    s(i,1)=sum(sum(a));
end

y2=[s(1,1) s(2,1) s(3,1) s(4,1) s(5,1) s(6,1) s(7,1) s(8,1) s(9,1) s(10,1) s(11,1) s(12,1) s(13,1) s(14,1) s(15,1) s(16,1) s(17,1) s(18,1) s(19,1) s(20,1) s(21,1) s(22,1) s(23,1) s(24,1) s(25,1) s(26,1) s(27,1) s(28,1) s(29,1) s(30,1) s(31,1) s(32,1) s(33,1) s(34,1) s(35,1) s(36,1) s(37,1) s(38,1) s(39,1) s(40,1)];
figure(1); %plot fig(2)
% plot(t,y2,'o'); %0425-hide points "o"
% hold on
p=polyfit(t,y2,6); %10-fit by a tenth polynomial
y2=polyval(p,t);
plot(t,y2);
grid on; %add grid
xlabel('Time Period');
ylabel('dijt');
title('Case Study: dijt');
set(gca,'ylim',[80000,260000]); %set y-axis range
set(gca, 'GridLineStyle', ':');  %x 
set(gca, 'GridAlpha', 1);  
set(gca, 'XTick', 0:8:40);  
set(gca,'YGrid','off'); %close y grid  
set(gca, 'XTickLabel', {'6am','9am','12pm','3pm','6pm','9pm'}); % set x-axis name
%0425-temporarily hide these 5 tags
%gtext('EM');
%gtext('AM');
%gtext('MD');
%gtext('PM');
%gtext('NT');
%hold on;

%plot points
%t=[1:40];
%y2=[s(1,1) s(2,1) s(3,1) s(4,1) s(5,1) s(6,1) s(7,1) s(8,1) s(9,1) s(10,1) s(11,1) s(12,1) s(13,1) s(14,1) s(15,1) s(16,1) s(17,1) s(18,1) s(19,1) s(20,1) s(21,1) s(22,1) s(23,1) s(24,1) s(25,1) s(26,1) s(27,1) s(28,1) s(29,1) s(30,1) s(31,1) s(32,1) s(33,1) s(34,1) s(35,1) s(36,1) s(37,1) s(38,1) s(39,1) s(40,1)];
%figure(3); %plot fig(2)
%plot(t,y2,'o');
%}