clear all;
clc;

length=10;
speed=1;
acceleration=1;
T=1;
CKO_f=1;
CKO_n=10;
num=10000;

y=signal2(length,speed,CKO_f,CKO_n,T,num);
% for i=1:num
%     y(i)=10+normrnd(0,CKO_f);
% end
xT=kalman1(y,CKO_f,CKO_n,T,num);
xT2=kalman2(y,CKO_f,CKO_n,T,num);
xT3=kalman3(y,CKO_f,CKO_n,T,num);
figure;
hold on;
plot(y,'b','LineWidth',2);
plot(xT3,'r','LineWidth',1.5);
plot(xT2,'y','LineWidth',1);
plot(xT,'g','LineWidth',1.5);





