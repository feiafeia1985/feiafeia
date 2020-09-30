clc;
clear;
data1=xlsread('j-1-0.xlsx');
data2=xlsread('j-1-30.xlsx');
data3=xlsread('j-1-60.xlsx');
data4=xlsread('j-1-100.xlsx');

% data1=xlsread('z-1-0.xlsx');
% data2=xlsread('z-1-30.xlsx');
% data3=xlsread('z-1-60.xlsx');
% data4=xlsread('z-1-100.xlsx');

% data1=xlsread('d-1-0.xlsx');
% data2=xlsread('d-1-30.xlsx');
% data3=xlsread('d-1-60.xlsx');
% data4=xlsread('d-1-100.xlsx');

% data1=xlsread('j-2-0.xlsx');
% data2=xlsread('j-2-30.xlsx');
% data3=xlsread('j-2-60.xlsx');
% data4=xlsread('j-2-100.xlsx');

a1=filter(bandpass1,data1);
a2=filter(bandpass1,data2);
a3=filter(bandpass1,data3);
a4=filter(bandpass1,data4);

%% 三种信号 16-2;22-3
i=22;
j=3;
figure(1);
plot(a2(1100*j:1100*(j+3),3*i-3+1),'r','LineWidth',8);
hold on;
plot(a2(1100*j:1100*(j+3),3*i-3+2),'--b','LineWidth',8);
hold on;
plot(a2(1100*j:1100*(j+3),3*i-3+3),':g','LineWidth',8);
set(gca,'linewidth',4);
set(gca,'FontSize',40);
axis([0 3300 -0.5 0.5]);
line([1100,1100],[-0.5,0.5],'color','k','LineWidth',6);
line([2200,2200],[-0.5,0.5],'color','k','LineWidth',6);
line([3300,3300],[-0.5,0.5],'color','k','LineWidth',6);
line([600,600],[-0.5,0.5],'color','k','LineWidth',6,'linestyle',':');
line([1700,1700],[-0.5,0.5],'color','k','LineWidth',6,'linestyle',':');
line([2800,2800],[-0.5,0.5],'color','k','LineWidth',6,'linestyle',':');
line([500,500],[-0.5,0.5],'color','y','LineWidth',6);
line([1600,1600],[-0.5,0.5],'color','y','LineWidth',6);
line([2700,2700],[-0.5,0.5],'color','y','LineWidth',6);
legend('Oxy-Hb','Deoxy-Hb','THb');
xlabel('Sample Point');
ylabel('Concentration(%)');
%% 4个动作 16-4;16-4
i=16;
j=4;
figure(1);
plot(a1(1100*j:1100*(j+3),3*i-3+1),'r','LineWidth',8);
hold on;
plot(a2(1100*j:1100*(j+3),3*i-3+1),'--b','LineWidth',8);
hold on;
plot(a3(1100*j:1100*(j+3),3*i-3+1),':g','LineWidth',8);
hold on;
plot(a4(1100*j:1100*(j+3),3*i-3+1),'-.m','LineWidth',8);
set(gca,'linewidth',4);
set(gca,'FontSize',40);
axis([0 3300 -0.6 0.6]);
line([1100,1100],[-1,1],'color','k','LineWidth',6);
line([2200,2200],[-1,1],'color','k','LineWidth',6);
line([3300,3300],[-1,1],'color','k','LineWidth',6);
line([600,600],[-1,1],'color','k','LineWidth',6,'linestyle',':');
line([1700,1700],[-1,1],'color','k','LineWidth',6,'linestyle',':');
line([2800,2800],[-1,1],'color','k','LineWidth',6,'linestyle',':');
line([500,500],[-1,1],'color','y','LineWidth',6);
line([1600,1600],[-1,1],'color','y','LineWidth',6);
line([2700,2700],[-1,1],'color','y','LineWidth',6);
legend('0%MMR','30%MMR','60%MMR','100%MMR');
xlabel('Sample Point');
ylabel('Concentration(%)');
%%
a1=mapminmax(a1,0,1);
a2=mapminmax(a2,0,1);
a3=mapminmax(a3,0,1);
a4=mapminmax(a4,0,1);
%% 29s-43S
for n=0:23
    for m=0:29
                    A1(1+375*m:375+375*m,n+1)=a1(1100*m+701:1100*m+1075,3*n+1)-mean(a1(1100*m+100:1100*m+475,3*n+1));
                    A2(1+375*m:375+375*m,n+1)=a2(1100*m+701:1100*m+1075,3*n+1)-mean(a2(1100*m+100:1100*m+475,3*n+1));
                    A3(1+375*m:375+375*m,n+1)=a3(1100*m+701:1100*m+1075,3*n+1)-mean(a3(1100*m+100:1100*m+475,3*n+1));
                    A4(1+375*m:375+375*m,n+1)=a4(1100*m+701:1100*m+1075,3*n+1)-mean(a4(1100*m+100:1100*m+475,3*n+1));
    end
end

A1=A1';
A2=A2';
A3=A3';
A4=A4';
A=[A1,A2,A3,A4];
%% 
% EMD1=cell(24,1);
% EMD2=cell(24,1);
% EMD3=cell(24,1);
% EMD4=cell(24,1);
EMDA=cell(24,1);
% EMD1M=cell(24,1);
% EMD2M=cell(24,1);
% EMD3M=cell(24,1);
% EMD4M=cell(24,1);
EMDAM=cell(24,1);
for i=0:23
%     EMD1{i+1}=emd(A1(i+1,:));
%     EMD2{i+1}=emd(A2(i+1,:));
%     EMD3{i+1}=emd(A3(i+1,:));
%     EMD4{i+1}=emd(A4(i+1,:));

    EMDA{i+1}=emd(A(i+1,:));

    EMD1{i+1}=EMDA{i+1}(:,1:11250);
    EMD2{i+1}=EMDA{i+1}(:,11250+1:11250*2);
    EMD3{i+1}=EMDA{i+1}(:,11250*2+1:11250*3);
    EMD4{i+1}=EMDA{i+1}(:,11250*3+1:11250*4);
    end
%% 画出分解图
for i=1:size(EMD1{1})
    figure(i);
    plot(EMD1{1}(i,:))
end
%% 求 积分值 
for i=1:24
    EMD1M{i}=abs(EMD1{i});
    EMD2M{i}=abs(EMD2{i});
    EMD3M{i}=abs(EMD3{i});
    EMD4M{i}=abs(EMD4{i});
    EMDAM{i}=abs(EMDA{i});
end
B=cell(24,1); %B为每一trail的和
for i=1:24
    for m=0:119
       B{i}(:,m+1)= sum(EMDAM{i}(:,1+375*m:375+375*m),2);
    end
end
% c=zeros(24,15);
for i=1:24
    n= length(var(B{i}'));
    C(i,1:n)=var(B{i}');
end
 [x y]=find(C==max(max(C)));
%  C(x,y)=0;
 %% 
%  for i=1:24
%  figure(i);
% plot(EMD1{i}(y,:),'r')
% hold on;
% plot(EMD2{i}(y,:),'b')
% hold on;
% plot(EMD3{i}(y,:),'g')
% hold on;
% plot(EMD4{i}(y,:),'m')
%  end
 figure(1);
plot(EMD1{x}(y,:),'r','LineWidth',8)
hold on;
plot(EMD2{x}(y,:),'--b','LineWidth',8)
hold on;
plot(EMD3{x}(y,:),':g','LineWidth',8)
hold on;
plot(EMD4{x}(y,:),'.-m','LineWidth',8)
axis([0 11250 -0.8 0.7]);
set(gca,'linewidth',4);
set(gca,'FontSize',40);
legend('0%MMR','30%MMR','60%MMR','100%MMR');
xlabel('Sample Point');
ylabel('Concentration(%)');
figure(2);
plot(A1(x,:),'r','LineWidth',8)
hold on;
plot(A2(x,:),'--b','LineWidth',8)
hold on;
plot(A3(x,:),':g','LineWidth',8)
hold on;
plot(A4(x,:),'.-m','LineWidth',8)
axis([0 11250 -1 1.2]);
set(gca,'linewidth',4);
set(gca,'FontSize',40);
legend('0%MMR','30%MMR','60%MMR','100%MMR');
xlabel('Sample Point');
ylabel('Concentration(%)');
%% 画出叠加后的曲线
for x=1:24
shuju1=EMD1M{x}(y,:);
shuju2=EMD2M{x}(y,:);
shuju3=EMD3M{x}(y,:);
shuju4=EMD4M{x}(y,:);
% save shuju1;
% save shuju2;
% save shuju3;
% save shuju4;
% save C;
sj1=0;
sj2=0;
sj3=0;
sj4=0;
for i=0:29
    sj1=sj1+shuju1(1,375*i+1:375*i+375);
    sj2=sj2+shuju2(1,375*i+1:375*i+375);
    sj3=sj3+shuju3(1,375*i+1:375*i+375);
    sj4=sj4+shuju4(1,375*i+1:375*i+375);
    
end
 figure(x);
plot(sj1)
hold on;
plot(sj2,'r')
hold on;
plot(sj3,'k')
hold on;
plot(sj4,'g')
end
%%

%% 
[Aa,fa,tt]=hhspectrum(EMD1{3});
[E,tt1,Cenf]=toimage(Aa,fa);
[E_m,E_n]=size(E);
fs=25;
T_hht=[0:E_n-1]/fs;F_hht=[0:E_m-1]'*fs/E_m/2;    %fs是采样率
figure;contour(T_hht,F_hht,abs(E));
axis([-inf,inf,0,0.15]);
xlabel('t/s');ylabel('f/Hz');
%% 画出EMD的各个IMF
figure(1)
subplot(11,1,1)
plot(A4(1,:),'LineWidth',1.5);
axis([0 11250 min(A4(1,:)) max(A4(1,:))]);

ylabel('Origin','FontName','TimesNewRoman','FontSize',15);
%legend('Origin');
%xlabel('Sample Point');


subplot(11,1,2)
plot(EMD4{1,1}(1,:),'LineWidth',1.5);
axis([0 11250 min(EMD4{1,1}(1,:)) max(EMD4{1,1}(1,:))]);
ylabel('IMF1','FontName','TimesNewRoman','FontSize',15);
%legend('IMF1');
%xlabel('Sample Point');


subplot(11,1,3)
plot(EMD4{1,1}(2,:),'LineWidth',1.5);
axis([0 11250 min(EMD4{1,1}(1,:)) max(EMD4{1,1}(2,:))]);
ylabel('IMF2','FontName','TimesNewRoman','FontSize',15);
%legend('IMF2');
%xlabel('Sample Point');


subplot(11,1,4)
plot(EMD4{1,1}(3,:),'LineWidth',1.5);
axis([0 11250 min(EMD4{1,1}(1,:)) max(EMD4{1,1}(3,:))]);
ylabel('IMF3','FontName','TimesNewRoman','FontSize',15);
%legend('IMF3');
%xlabel('Sample Point');


subplot(11,1,5)
plot(EMD4{1,1}(4,:),'LineWidth',1.5);
axis([0 11250 min(EMD4{1,1}(1,:)) max(EMD4{1,1}(4,:))]);
ylabel('IMF4','FontName','TimesNewRoman','FontSize',15);
%legend('IMF4');
%xlabel('Sample Point');


subplot(11,1,6)
plot(EMD4{1,1}(5,:),'LineWidth',1.5);
axis([0 11250 min(EMD4{1,1}(1,:)) max(EMD4{1,1}(5,:))]);
ylabel('IMF5','FontName','TimesNewRoman','FontSize',15);
%legend('IMF5');
%xlabel('Sample Point');


subplot(11,1,7)
plot(EMD4{1,1}(6,:),'LineWidth',1.5);
axis([0 11250 min(EMD4{1,1}(1,:)) max(EMD4{1,1}(6,:))]);
ylabel('IMF6','FontName','TimesNewRoman','FontSize',15);
%legend('IMF6');
%xlabel('Sample Point');


subplot(11,1,8)
plot(EMD4{1,1}(7,:),'LineWidth',1.5);
axis([0 11250 min(EMD4{1,1}(1,:)) max(EMD4{1,1}(7,:))]);
ylabel('IMF7','FontName','TimesNewRoman','FontSize',15);
%legend('IMF7');


subplot(11,1,9)
plot(EMD4{1,1}(8,:),'LineWidth',1.5);
axis([0 11250 min(EMD4{1,1}(1,:)) max(EMD4{1,1}(8,:))]);
ylabel('IMF8','FontName','TimesNewRoman','FontSize',15);
%legend('IMF8');
%xlabel('Sample Point');


subplot(11,1,10)
plot(EMD4{1,1}(9,:),'LineWidth',1.5);
axis([0 11250 min(EMD4{1,1}(1,:)) max(EMD4{1,1}(9,:))]);
ylabel('IMF9','FontName','TimesNewRoman','FontSize',15);
%legend('IMF9');
%xlabel('Sample Point');

subplot(11,1,11)
plot(EMD4{1,1}(10,:),'LineWidth',1.5);

axis([0 11250 min(EMD4{1,1}(1,:)) max(EMD4{1,1}(10,:))]);
%legend('IMF10');
xlabel('Sample Point','FontName','TimesNewRoman','FontSize',15);
ylabel('IMF10','FontName','TimesNewRoman','FontSize',15);
set(gca,'position',[0 0 500 420])
%% 
print 2.eps -depsc2 -r600
% set(gca,'XTickLabel','FontName','TimesNewRoman','FontSize',40);
% set(gca,'YTickLabel','FontName','TimesNewRoman','FontSize',40);
%set(gca,'FontSize',10);
% set(gca,'FontSize',40);
