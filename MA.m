clc;
clear;
data1=xlsread('j-1-0.xlsx');
data2=xlsread('j-1-30.xlsx');
data3=xlsread('j-1-60.xlsx');
data4=xlsread('j-1-100.xlsx');

% data1=xlsread('g-1-0.xlsx');
% data2=xlsread('g-1-30.xlsx');
% data3=xlsread('g-1-60.xlsx');
% data4=xlsread('g-1-100.xlsx');

% data1=xlsread('d-1-0.xlsx');
% data2=xlsread('d-1-30.xlsx');
% data3=xlsread('d-1-60.xlsx');
% data4=xlsread('d-1-100.xlsx');

% data1=xlsread('z-1-0.xlsx');
% data2=xlsread('z-1-30.xlsx');
% data3=xlsread('z-1-60.xlsx');
% data4=xlsread('z-1-100.xlsx');

% data1=xlsread('q-1-0.xlsx');
% data2=xlsread('q-1-30.xlsx');
% data3=xlsread('q-1-60.xlsx');
% data4=xlsread('q-1-100.xlsx');



%% 滤波画图
a1=filter(bandpass1,data1);
a2=filter(bandpass1,data2);
a3=filter(bandpass1,data3);
a4=filter(bandpass1,data4);

% for i=1:24
% %     figure(i);gai
%     subplot(4,6,i)
%     for j=1:3 
% %         a(:,i*3-3+j)=filter(bandpass1,data(:,3*i-3+j));
% %        a(:,i*3-3+j)=data(:,3*i-3+j);  
%         plot(a2(:,3*i-3+1),'r');
%         hold on;
% %         plot(a(:,3*i-3+2),'b');
% %         hold on;
% %         plot(a(:,3*i-3+3),'g');
% %         hold on;
%         for k=1:30
%               line([1100*k,1100*k],[-1,1],'color','k');
%               hold on;
%                axis([0 33000 -1 1]) ;%gai  
%         end
%     end
% end
% tt=3;
% a1h=hilbertl(a1,tt);
% a2h=hilbertl(a2,tt);
% a3h=hilbertl(a3,tt);
% a4h=hilbertl(a4,tt);
% a1=abs(a1h);
% a2=abs(a2h);
% a3=abs(a3h);
% a4=abs(a4h);

% a1h=hilbert(a1);
% a2h=hilbert(a2);
% a3h=hilbert(a3);
% a4h=hilbert(a4);
% a1=abs(a1h);
% a2=abs(a2h);
% a3=abs(a3h);
% a4=abs(a4h);

%% 取特征值 运动开始第5秒-第19秒 时间窗长度k, 间隔1秒 每一次总共15-k+1个时间窗 %%%%%%%%
%% 30次 总共(16-k)*30特征值 
k=2;
for n=0:23
    for m=0:29
        for l=0:16-k-1
            feature1(m*(16-k)+l+1,n+1)=sum(a1(1100*m+701+l*25:1100*m+700+25*k+l*25,3*n+1))-mean(a1(1100*m+100:1100*m+475,3*n+1));
            feature2(m*(16-k)+l+1,n+1)=sum(a2(1100*m+701+l*25:1100*m+700+25*k+l*25,3*n+1))-mean(a2(1100*m+100:1100*m+475,3*n+1));
            feature3(m*(16-k)+l+1,n+1)=sum(a3(1100*m+701+l*25:1100*m+700+25*k+l*25,3*n+1))-mean(a3(1100*m+100:1100*m+475,3*n+1));
            feature4(m*(16-k)+l+1,n+1)=sum(a4(1100*m+701+l*25:1100*m+700+25*k+l*25,3*n+1))-mean(a4(1100*m+100:1100*m+475,3*n+1));
         end
    end
end

%% 
acc=zeros(10,9);
for ii=1:10
%% 
feature=0;

kk=(16-k)*30;
feature(1:kk,1:24)=feature1(randperm(kk),1:24);
feature(kk+1:2*kk,1:24)=feature2(randperm(kk),1:24);
feature(2*kk+1:3*kk,1:24)=feature3(randperm(kk),1:24);
feature(3*kk+1:4*kk,1:24)=feature4(randperm(kk),1:24);

feature=feature';
[featurean,featureas]=mapminmax(feature);
%% 将特征值转变成CSV格式
% featurecsv=feature';
% featurecsv=featurean';
% featurecsv(1:330,25)=1;
% featurecsv(331:660,25)=2;
% featurecsv(661:990,25)=3;
% featurecsv(991:1320,25)=4;
% csvwrite('1gcsv.csv',featurecsv);
featurecsv=feature;
featurecsv(1:420,25)=1;
featurecsv(421:840,25)=2;
featurecsv(841:1260,25)=3;
featurecsv(1261:1680,25)=4;
csvwrite('1gcsv.csv',featurecsv);
%%  划分训练集测试集
xunlian=0.6*kk;
ceshi=kk-xunlian;

featurexl=0;
featurexl(1:24,1:xunlian)=featurean(1:24,1:xunlian);
featurexl(1:24,xunlian+1:2*xunlian)=featurean(1:24,kk+1:kk+xunlian);
featurexl(1:24,2*xunlian+1:3*xunlian)=featurean(1:24,2*kk+1:2*kk+xunlian);
featurexl(1:24,3*xunlian+1:4*xunlian)=featurean(1:24,3*kk+1:3*kk+xunlian);

labelxl=zeros(1,4*xunlian);
labelxl(1,1:xunlian)=1;
labelxl(1,xunlian+1:2*xunlian)=2;
labelxl(1,2*xunlian+1:3*xunlian)=3;
labelxl(1,3*xunlian+1:4*xunlian)=4;

featurexl=featurexl';
labelxl=labelxl';

featurexl12=featurexl(1:2*xunlian,:);
labelxl12=labelxl(1:2*xunlian,:);

featurexl13=[featurexl(1:xunlian,:);featurexl(2*xunlian+1:3*xunlian,:)];
labelxl13=[labelxl(1:xunlian,:);labelxl(2*xunlian+1:3*xunlian,:)];

featurexl14=[featurexl(1:xunlian,:);featurexl(3*xunlian+1:4*xunlian,:)];
labelxl14=[labelxl(1:xunlian,:);labelxl(3*xunlian+1:4*xunlian,:)];

featurexl23=featurexl(xunlian+1:3*xunlian,:);
labelxl23=labelxl(xunlian+1:3*xunlian,:);

featurexl24=[featurexl(xunlian+1:2*xunlian,:);featurexl(3*xunlian+1:4*xunlian,:)];
labelxl24=[labelxl(xunlian+1:2*xunlian,:);labelxl(3*xunlian+1:4*xunlian,:)];

featurexl34=featurexl(2*xunlian+1:4*xunlian,:);
labelxl34=labelxl(2*xunlian+1:4*xunlian,:);
%% svm
svmModel12 = fitcsvm(featurexl12,labelxl12,'KernelFunction','rbf');
svmModel13= fitcsvm(featurexl13,labelxl13,'KernelFunction','rbf');
svmModel14= fitcsvm(featurexl14,labelxl14,'KernelFunction','rbf');
svmModel23= fitcsvm(featurexl23,labelxl23,'KernelFunction','rbf');
svmModel24= fitcsvm(featurexl24,labelxl24,'KernelFunction','rbf');
svmModel34= fitcsvm(featurexl34,labelxl34,'KernelFunction','rbf');

featurecs=[featurean(1:24,xunlian+1:kk),featurean(1:24,xunlian+1+kk:2*kk),featurean(1:24,xunlian+1+2*kk:3*kk),featurean(1:24,3*kk+xunlian+1:4*kk)];
featurecs=featurecs';

classfication1= predict(svmModel12,featurecs);
classfication2 = predict(svmModel13,featurecs);
classfication3 = predict(svmModel14,featurecs);
classfication4 = predict(svmModel23,featurecs);
classfication5 = predict(svmModel24,featurecs);
classfication6 = predict(svmModel34,featurecs);
classfication(:,1)=classfication1;
classfication(:,2)=classfication2;
classfication(:,3)=classfication3;
classfication(:,4)=classfication4;
classfication(:,5)=classfication5;
classfication(:,6)=classfication6;
result=mode(classfication,2);
result1=sum(result(1:ceshi)==1);
result2=sum(result(ceshi+1:2*ceshi)==2);
result3=sum(result(2*ceshi+1:3*ceshi)==3);
result4=sum(result(3*ceshi+1:4*ceshi)==4);
acc(ii,1)=(result1+result2+result3+result4)/(4*ceshi);
%% 2knn
mdl=fitcknn(featurexl,labelxl);
mdl.NumNeighbors=4;

featurecs=[featurean(1:24,xunlian+1:kk),featurean(1:24,xunlian+1+kk:2*kk),featurean(1:24,xunlian+1+2*kk:3*kk),featurean(1:24,3*kk+xunlian+1:4*kk)];
featurecs=featurecs';

labelcs1=zeros(ceshi,1);
labelcs1(1:ceshi,:)=1;
labelcs2=zeros(ceshi,1);
labelcs2(1:ceshi,:)=2;
labelcs3=zeros(ceshi,1);
labelcs3(1:ceshi,:)=3;
labelcs4=zeros(ceshi,1);
labelcs4(1:ceshi,:)=4;
labelcs=[labelcs1;labelcs2;labelcs3;labelcs4];

class=predict(mdl,featurecs);

class1=sum(sum(class(1:ceshi)==1));
class12=sum(sum(class(1:ceshi)==2));
class13=sum(sum(class(1:ceshi)==3));
class14=sum(sum(class(1:ceshi)==4));

class2=sum(sum(class(ceshi+1:2*ceshi)==2));
class21=sum(sum(class(ceshi+1:2*ceshi)==1));
class23=sum(sum(class(ceshi+1:2*ceshi)==3));
class24=sum(sum(class(ceshi+1:2*ceshi)==4));

class3=sum(sum(class(2*ceshi+1:3*ceshi)==3));
class31=sum(sum(class(2*ceshi+1:3*ceshi)==1));
class32=sum(sum(class(2*ceshi+1:3*ceshi)==2));
class34=sum(sum(class(2*ceshi+1:3*ceshi)==4));

class4=sum(sum(class(3*ceshi+1:4*ceshi)==4));
class41=sum(sum(class(3*ceshi+1:4*ceshi)==1));
class42=sum(sum(class(3*ceshi+1:4*ceshi)==2));
class43=sum(sum(class(3*ceshi+1:4*ceshi)==3));

ac1=class1/ceshi;
ac2=class2/ceshi;
ac3=class3/ceshi;
ac4=class4/ceshi;
ac=[ac1,ac2,ac3,ac4];
acc(ii,2)=(ac1+ac2+ac3+ac4)/4;
%% 3RF
rf=TreeBagger(500,featurexl,labelxl);


featurecs=[featurean(1:24,xunlian+1:kk),featurean(1:24,xunlian+1+kk:2*kk),featurean(1:24,xunlian+1+2*kk:3*kk),featurean(1:24,3*kk+xunlian+1:4*kk)];
featurecs=featurecs';

labelcs1=zeros(ceshi,1);
labelcs1(1:ceshi,:)=1;
labelcs2=zeros(ceshi,1);
labelcs2(1:ceshi,:)=2;
labelcs3=zeros(ceshi,1);
labelcs3(1:ceshi,:)=3;
labelcs4=zeros(ceshi,1);
labelcs4(1:ceshi,:)=4;
labelcs=[labelcs1;labelcs2;labelcs3;labelcs4];

[class,Scores]=predict(rf,featurecs);
class=cell2mat(class);
class=str2num(class);

class1=sum(sum(class(1:ceshi)==1));
class12=sum(sum(class(1:ceshi)==2));
class13=sum(sum(class(1:ceshi)==3));
class14=sum(sum(class(1:ceshi)==4));

class2=sum(sum(class(ceshi+1:2*ceshi)==2));
class21=sum(sum(class(ceshi+1:2*ceshi)==1));
class23=sum(sum(class(ceshi+1:2*ceshi)==3));
class24=sum(sum(class(ceshi+1:2*ceshi)==4));

class3=sum(sum(class(2*ceshi+1:3*ceshi)==3));
class31=sum(sum(class(2*ceshi+1:3*ceshi)==1));
class32=sum(sum(class(2*ceshi+1:3*ceshi)==2));
class34=sum(sum(class(2*ceshi+1:3*ceshi)==4));

class4=sum(sum(class(3*ceshi+1:4*ceshi)==4));
class41=sum(sum(class(3*ceshi+1:4*ceshi)==1));
class42=sum(sum(class(3*ceshi+1:4*ceshi)==2));
class43=sum(sum(class(3*ceshi+1:4*ceshi)==3));

ac1=class1/ceshi;
ac2=class2/ceshi;
ac3=class3/ceshi;
ac4=class4/ceshi;
acc(ii,3)=(ac1+ac2+ac3+ac4)/4
%% 4DQA
class=classify(featurecs,featurexl,labelxl,'quadratic');

class1=sum(sum(class(1:ceshi)==1));
class12=sum(sum(class(1:ceshi)==2));
class13=sum(sum(class(1:ceshi)==3));
class14=sum(sum(class(1:ceshi)==4));

class2=sum(sum(class(ceshi+1:2*ceshi)==2));
class21=sum(sum(class(ceshi+1:2*ceshi)==1));
class23=sum(sum(class(ceshi+1:2*ceshi)==3));
class24=sum(sum(class(ceshi+1:2*ceshi)==4));

class3=sum(sum(class(2*ceshi+1:3*ceshi)==3));
class31=sum(sum(class(2*ceshi+1:3*ceshi)==1));
class32=sum(sum(class(2*ceshi+1:3*ceshi)==2));
class34=sum(sum(class(2*ceshi+1:3*ceshi)==4));

class4=sum(sum(class(3*ceshi+1:4*ceshi)==4));
class41=sum(sum(class(3*ceshi+1:4*ceshi)==1));
class42=sum(sum(class(3*ceshi+1:4*ceshi)==2));
class43=sum(sum(class(3*ceshi+1:4*ceshi)==3));

ac1=class1/ceshi;
ac2=class2/ceshi;
ac3=class3/ceshi;
ac4=class4/ceshi;
ac=[ac1,ac2,ac3,ac4];
% figure(2);
% bar(ac);
acc(ii,4)=(ac1+ac2+ac3+ac4)/4
%% FFNN
feature=0;

kk=(16-k)*30;
feature(1:kk,1:24)=feature1(randperm(kk),1:24);
feature(kk+1:2*kk,1:24)=feature2(randperm(kk),1:24);
feature(2*kk+1:3*kk,1:24)=feature3(randperm(kk),1:24);
feature(3*kk+1:4*kk,1:24)=feature4(randperm(kk),1:24);

feature=feature';
[featurean,featureas]=mapminmax(feature);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
xunlian=0.6*kk;
ceshi=kk-xunlian;

featurexl=0;
featurexl(1:24,1:xunlian)=featurean(1:24,1:xunlian);
featurexl(1:24,xunlian+1:2*xunlian)=featurean(1:24,kk+1:kk+xunlian);
featurexl(1:24,2*xunlian+1:3*xunlian)=featurean(1:24,2*kk+1:2*kk+xunlian);
featurexl(1:24,3*xunlian+1:4*xunlian)=featurean(1:24,3*kk+1:3*kk+xunlian);

labelxl=zeros(1,4*xunlian);
labelxl(1,1:xunlian)=1;
labelxl(1,xunlian+1:2*xunlian)=2;
labelxl(1,2*xunlian+1:3*xunlian)=3;
labelxl(1,3*xunlian+1:4*xunlian)=4;

flxl=zeros(25,4*xunlian);
flxl(1:24,:)=featurexl;
flxl(25,:)=labelxl;
flxl=flxl(1:25,randperm(4*xunlian));
featurexl=flxl(1:24,:);
labelxl=flxl(25,:);

[labelxlg,labelas]=mapminmax(labelxl);

%% net
% net=feedforwardnet(100,'traincgb');
net=feedforwardnet(100);
net.trainParam.max_fail = 50;
% net.numLayers = 3; %gai
%  net.layerConnect(3,2) = 1;%gai
% net.outputConnect = [0 0 1];%;gai
% net.trainParam.lr=0.2;
% view(net);
% view(net);
net.layers{1}.transferFcn = 'tansig';
net=train(net,featurexl,labelxlg);

% net.layers{2}.transferFcn = 'tansig';
featurecs=[featurean(1:24,xunlian+1:kk),featurean(1:24,xunlian+1+kk:2*kk),featurean(1:24,xunlian+1+2*kk:3*kk),featurean(1:24,3*kk+xunlian+1:4*kk)];
class=net(featurecs);
class=mapminmax('reverse',class,labelas);
class=round(class);
for n=1:ceshi*4 
    if class(n)>=4
        class(n)=4;
    end
    if class(n)<=1
        class(n)=1;
    end 
   end

class1=sum(sum(class(1:ceshi)==1));
class12=sum(sum(class(1:ceshi)==2));
class13=sum(sum(class(1:ceshi)==3));
class14=sum(sum(class(1:ceshi)==4));

class2=sum(sum(class(ceshi+1:2*ceshi)==2));
class21=sum(sum(class(ceshi+1:2*ceshi)==1));
class23=sum(sum(class(ceshi+1:2*ceshi)==3));
class24=sum(sum(class(ceshi+1:2*ceshi)==4));

class3=sum(sum(class(2*ceshi+1:3*ceshi)==3));
class31=sum(sum(class(2*ceshi+1:3*ceshi)==1));
class32=sum(sum(class(2*ceshi+1:3*ceshi)==2));
class34=sum(sum(class(2*ceshi+1:3*ceshi)==4));

class4=sum(sum(class(3*ceshi+1:4*ceshi)==4));
class41=sum(sum(class(3*ceshi+1:4*ceshi)==1));
class42=sum(sum(class(3*ceshi+1:4*ceshi)==2));
class43=sum(sum(class(3*ceshi+1:4*ceshi)==3));

ac1=class1/ceshi;
ac2=class2/ceshi;
ac3=class3/ceshi;
ac4=class4/ceshi;
ac=[ac1,ac2,ac3,ac4];
acc(ii,5)=(ac1+ac2+ac3+ac4)/4
%% lda
feature=0;

kk=(16-k)*30;
feature(1:kk,1:24)=feature1(randperm(kk),1:24);
feature(kk+1:2*kk,1:24)=feature2(randperm(kk),1:24);
feature(2*kk+1:3*kk,1:24)=feature3(randperm(kk),1:24);
feature(3*kk+1:4*kk,1:24)=feature4(randperm(kk),1:24);

feature=feature';
[featurean,featureas]=mapminmax(feature);

% featurean=featurean';
% label=zeros(1320,1);
% label(1:330,1)=1;
% label(331:660,1)=2;
% label(661:990,1)=3;
% label(991:1320,1)=4;

%% 将特征值转变成CSV格式
% % featurecsv=feature';
% featurecsv=featurean';
% featurecsv(1:330,25)=1;
% featurecsv(331:660,25)=2;
% featurecsv(661:990,25)=3;
% featurecsv(991:1320,25)=4;
% csvwrite('1gcsv.csv',featurecsv);
%%  划分训练集测试集
xunlian=0.6*kk;
ceshi=kk-xunlian;

featurexl=0;
featurexl(1:24,1:xunlian)=featurean(1:24,1:xunlian);
featurexl(1:24,xunlian+1:2*xunlian)=featurean(1:24,kk+1:kk+xunlian);
featurexl(1:24,2*xunlian+1:3*xunlian)=featurean(1:24,2*kk+1:2*kk+xunlian);
featurexl(1:24,3*xunlian+1:4*xunlian)=featurean(1:24,3*kk+1:3*kk+xunlian);

labelxl=zeros(1,4*xunlian);
labelxl(1,1:xunlian)=1;
labelxl(1,xunlian+1:2*xunlian)=2;
labelxl(1,2*xunlian+1:3*xunlian)=3;
labelxl(1,3*xunlian+1:4*xunlian)=4;

featurexl=featurexl';
labelxl=labelxl';

flxl=zeros(4*xunlian,25);
flxl(:,1:24)=featurexl;
flxl(:,25)=labelxl;
flxl=flxl(randperm(4*xunlian),1:25);
featurexl=flxl(:,1:24);
labelxl=flxl(:,25);
%% 
tree=fitctree(featurexl,labelxl);


featurecs=[featurean(1:24,xunlian+1:kk),featurean(1:24,xunlian+1+kk:2*kk),featurean(1:24,xunlian+1+2*kk:3*kk),featurean(1:24,3*kk+xunlian+1:4*kk)];
featurecs=featurecs';


labelcs1=zeros(ceshi,1);
labelcs1(1:ceshi,:)=1;
labelcs2=zeros(ceshi,1);
labelcs2(1:ceshi,:)=2;
labelcs3=zeros(ceshi,1);
labelcs3(1:ceshi,:)=3;
labelcs4=zeros(ceshi,1);
labelcs4(1:ceshi,:)=4;
labelcs=[labelcs1;labelcs2;labelcs3;labelcs4];

class=predict(tree,featurecs);


class1=sum(sum(class(1:ceshi)==1));
class12=sum(sum(class(1:ceshi)==2));
class13=sum(sum(class(1:ceshi)==3));
class14=sum(sum(class(1:ceshi)==4));

class2=sum(sum(class(ceshi+1:2*ceshi)==2));
class21=sum(sum(class(ceshi+1:2*ceshi)==1));
class23=sum(sum(class(ceshi+1:2*ceshi)==3));
class24=sum(sum(class(ceshi+1:2*ceshi)==4));

class3=sum(sum(class(2*ceshi+1:3*ceshi)==3));
class31=sum(sum(class(2*ceshi+1:3*ceshi)==1));
class32=sum(sum(class(2*ceshi+1:3*ceshi)==2));
class34=sum(sum(class(2*ceshi+1:3*ceshi)==4));

class4=sum(sum(class(3*ceshi+1:4*ceshi)==4));
class41=sum(sum(class(3*ceshi+1:4*ceshi)==1));
class42=sum(sum(class(3*ceshi+1:4*ceshi)==2));
class43=sum(sum(class(3*ceshi+1:4*ceshi)==3));

ac1=class1/ceshi;
ac2=class2/ceshi;
ac3=class3/ceshi;
ac4=class4/ceshi;
ac=[ac1,ac2,ac3,ac4];
% bar(ac);
acc(ii,6)=(ac1+ac2+ac3+ac4)/4
%%

feature=0;

kk=(16-k)*30;
feature(1:kk,1:24)=feature1(randperm(kk),1:24);
feature(kk+1:2*kk,1:24)=feature2(randperm(kk),1:24);
feature(2*kk+1:3*kk,1:24)=feature3(randperm(kk),1:24);
feature(3*kk+1:4*kk,1:24)=feature4(randperm(kk),1:24);

feature=feature';
[featurean,featureas]=mapminmax(feature);


%% 将特征值转变成CSV格式
% % featurecsv=feature';
% featurecsv=featurean';
% featurecsv(1:330,25)=1;
% featurecsv(331:660,25)=2;
% featurecsv(661:990,25)=3;
% featurecsv(991:1320,25)=4;
% csvwrite('1gcsv.csv',featurecsv);
%%  划分训练集测试集
xunlian=0.6*kk;
ceshi=kk-xunlian;


featurexl=0;
featurexl(1:24,1:xunlian)=featurean(1:24,1:xunlian);
featurexl(1:24,xunlian+1:2*xunlian)=featurean(1:24,kk+1:kk+xunlian);
featurexl(1:24,2*xunlian+1:3*xunlian)=featurean(1:24,2*kk+1:2*kk+xunlian);
featurexl(1:24,3*xunlian+1:4*xunlian)=featurean(1:24,3*kk+1:3*kk+xunlian);

labelxl=zeros(1,4*xunlian);
labelxl(1,1:xunlian)=1;
labelxl(1,xunlian+1:2*xunlian)=2;
labelxl(1,2*xunlian+1:3*xunlian)=3;
labelxl(1,3*xunlian+1:4*xunlian)=4;

featurexl=featurexl';
labelxl=labelxl';
flxl=zeros(4*xunlian,25);
flxl(:,1:24)=featurexl;
flxl(:,25)=labelxl;
flxl=flxl(randperm(4*xunlian),1:25);
featurexl=flxl(:,1:24);
labelxl=flxl(:,25);
%% 

featurecs=[featurean(1:24,xunlian+1:kk),featurean(1:24,xunlian+1+kk:2*kk),featurean(1:24,xunlian+1+2*kk:3*kk),featurean(1:24,3*kk+xunlian+1:4*kk)];
featurecs=featurecs';

labelcs1=zeros(ceshi,1);
labelcs1(1:ceshi,:)=1;
labelcs2=zeros(ceshi,1);
labelcs2(1:ceshi,:)=2;
labelcs3=zeros(ceshi,1);
labelcs3(1:ceshi,:)=3;
labelcs4=zeros(ceshi,1);
labelcs4(1:ceshi,:)=4;
labelcs=[labelcs1;labelcs2;labelcs3;labelcs4];

class=classify(featurecs,featurexl,labelxl);


class1=sum(sum(class(1:ceshi)==1));
class12=sum(sum(class(1:ceshi)==2));
class13=sum(sum(class(1:ceshi)==3));
class14=sum(sum(class(1:ceshi)==4));

class2=sum(sum(class(ceshi+1:2*ceshi)==2));
class21=sum(sum(class(ceshi+1:2*ceshi)==1));
class23=sum(sum(class(ceshi+1:2*ceshi)==3));
class24=sum(sum(class(ceshi+1:2*ceshi)==4));

class3=sum(sum(class(2*ceshi+1:3*ceshi)==3));
class31=sum(sum(class(2*ceshi+1:3*ceshi)==1));
class32=sum(sum(class(2*ceshi+1:3*ceshi)==2));
class34=sum(sum(class(2*ceshi+1:3*ceshi)==4));

class4=sum(sum(class(3*ceshi+1:4*ceshi)==4));
class41=sum(sum(class(3*ceshi+1:4*ceshi)==1));
class42=sum(sum(class(3*ceshi+1:4*ceshi)==2));
class43=sum(sum(class(3*ceshi+1:4*ceshi)==3));

ac1=class1/ceshi;
ac2=class2/ceshi;
ac3=class3/ceshi;
ac4=class4/ceshi;
ac=[ac1,ac2,ac3,ac4];
acc(ii,7)=(ac1+ac2+ac3+ac4)/4;

%% NB
feature=0;

kk=(16-k)*30;
feature(1:kk,1:24)=feature1(randperm(kk),1:24);
feature(kk+1:2*kk,1:24)=feature2(randperm(kk),1:24);
feature(2*kk+1:3*kk,1:24)=feature3(randperm(kk),1:24);
feature(3*kk+1:4*kk,1:24)=feature4(randperm(kk),1:24);

feature=feature';
[featurean,featureas]=mapminmax(feature);

%%  划分训练集测试集
xunlian=0.6*kk;
ceshi=kk-xunlian;

featurexl=0;
featurexl(1:24,1:xunlian)=featurean(1:24,1:xunlian);
featurexl(1:24,xunlian+1:2*xunlian)=featurean(1:24,kk+1:kk+xunlian);
featurexl(1:24,2*xunlian+1:3*xunlian)=featurean(1:24,2*kk+1:2*kk+xunlian);
featurexl(1:24,3*xunlian+1:4*xunlian)=featurean(1:24,3*kk+1:3*kk+xunlian);

labelxl=zeros(1,4*xunlian);
labelxl(1,1:xunlian)=1;
labelxl(1,xunlian+1:2*xunlian)=2;
labelxl(1,2*xunlian+1:3*xunlian)=3;
labelxl(1,3*xunlian+1:4*xunlian)=4;

featurexl=featurexl';
labelxl=labelxl';

flxl=zeros(4*xunlian,25);
flxl(:,1:24)=featurexl;
flxl(:,25)=labelxl;
flxl=flxl(randperm(4*xunlian),1:25);
featurexl=flxl(:,1:24);
labelxl=flxl(:,25);

%% 
nb=fitcnb(featurexl,labelxl,'Distribution','normal');
% nb=fitNaiveBayes(featurexl,labelxl,'KSSupport','unbounded')

featurecs=[featurean(1:24,xunlian+1:kk),featurean(1:24,xunlian+1+kk:2*kk),featurean(1:24,xunlian+1+2*kk:3*kk),featurean(1:24,3*kk+xunlian+1:4*kk)];
featurecs=featurecs';

labelcs1=zeros(ceshi,1);
labelcs1(1:ceshi,:)=1;
labelcs2=zeros(ceshi,1);
labelcs2(1:ceshi,:)=2;
labelcs3=zeros(ceshi,1);
labelcs3(1:ceshi,:)=3;
labelcs4=zeros(ceshi,1);
labelcs4(1:ceshi,:)=4;
labelcs=[labelcs1;labelcs2;labelcs3;labelcs4];

class=predict(nb,featurecs);


class1=sum(sum(class(1:ceshi)==1));
class12=sum(sum(class(1:ceshi)==2));
class13=sum(sum(class(1:ceshi)==3));
class14=sum(sum(class(1:ceshi)==4));

class2=sum(sum(class(ceshi+1:2*ceshi)==2));
class21=sum(sum(class(ceshi+1:2*ceshi)==1));
class23=sum(sum(class(ceshi+1:2*ceshi)==3));
class24=sum(sum(class(ceshi+1:2*ceshi)==4));

class3=sum(sum(class(2*ceshi+1:3*ceshi)==3));
class31=sum(sum(class(2*ceshi+1:3*ceshi)==1));
class32=sum(sum(class(2*ceshi+1:3*ceshi)==2));
class34=sum(sum(class(2*ceshi+1:3*ceshi)==4));

class4=sum(sum(class(3*ceshi+1:4*ceshi)==4));
class41=sum(sum(class(3*ceshi+1:4*ceshi)==1));
class42=sum(sum(class(3*ceshi+1:4*ceshi)==2));
class43=sum(sum(class(3*ceshi+1:4*ceshi)==3));

ac1=class1/ceshi;
ac2=class2/ceshi;
ac3=class3/ceshi;
ac4=class4/ceshi;
ac=[ac1,ac2,ac3,ac4];
% figure(2);
% bar(ac);
acc(ii,8)=(ac1+ac2+ac3+ac4)/4;
%% 
ensemble=fitensemble(featurexl,labelxl,'AdaBoostM2',100,'Tree');
% ensemble=fitensemble(featurexl,labelxl,'AdaBoostM2',2,'KNN')

 class=predict(ensemble,featurecs);

class1=sum(sum(class(1:ceshi)==1));
class12=sum(sum(class(1:ceshi)==2));
class13=sum(sum(class(1:ceshi)==3));
class14=sum(sum(class(1:ceshi)==4));

class2=sum(sum(class(ceshi+1:2*ceshi)==2));
class21=sum(sum(class(ceshi+1:2*ceshi)==1));
class23=sum(sum(class(ceshi+1:2*ceshi)==3));
class24=sum(sum(class(ceshi+1:2*ceshi)==4));

class3=sum(sum(class(2*ceshi+1:3*ceshi)==3));
class31=sum(sum(class(2*ceshi+1:3*ceshi)==1));
class32=sum(sum(class(2*ceshi+1:3*ceshi)==2));
class34=sum(sum(class(2*ceshi+1:3*ceshi)==4));

class4=sum(sum(class(3*ceshi+1:4*ceshi)==4));
class41=sum(sum(class(3*ceshi+1:4*ceshi)==1));
class42=sum(sum(class(3*ceshi+1:4*ceshi)==2));
class43=sum(sum(class(3*ceshi+1:4*ceshi)==3));

ac1=class1/ceshi;
ac2=class2/ceshi;
ac3=class3/ceshi;
ac4=class4/ceshi;
acc(ii,9)=(ac1+ac2+ac3+ac4)/4;

end
acc*100
