clear all;
clc;

length=10;
T=1;
CKO_f=0.1;
CKO_n=1;
num=10000;

R(1)=length;
for i=2:num
    R(i)=R(i-1)+T*normrnd(0,CKO_f);
end

x = R+normrnd(0,CKO_n,[1,num]);

% for i=1:num
%     x(i)=10+randi([-2,2]);
% end

F=1;
G=T;
H=1;
% CKO_f=0.01;
CKO_f=0:0.1:10;
CKO_n=1;


for j=1:101
Df=CKO_f(j)*CKO_f(j);
% Df=CKO_f*CKO_f;
Dn=CKO_n*CKO_n;

D(1)=eye(1);
Dv(1)=eye(1);

xV(1)=10;
xT(1)=10;

for i=2:num
    xV(i)=F*xT(i-1);
    Dv(i)=F*D(i-1)*F'+G*Df*G';
    K(i)=Dv(i)*H'*(H*Dv(i)*H'+Dn)^-1;
    D(i)=(1-K(i)*H)*Dv(i);
    xT(i)=xV(i)+K(i)*(x(i)-H*xV(i));
end
deltaM=R-xT;
stddeltaM(j)=std(deltaM);
end

figure;
plot(CKO_f,stddeltaM,'k','LineWidth',1.5);

CKO_f=0.01;
Df=CKO_f*CKO_f;
Dn=CKO_n*CKO_n;

D(1)=eye(1);
Dv(1)=eye(1);

xV(1)=10;
xT(1)=10;

for i=2:num
    xV(i)=F*xT(i-1);
    Dv(i)=F*D(i-1)*F'+G*Df*G';
    K(i)=Dv(i)*H'*(H*Dv(i)*H'+Dn)^-1;
    D(i)=(1-K(i)*H)*Dv(i);
    xT(i)=xV(i)+K(i)*(x(i)-H*xV(i));
end

F=1;
G=T;
H=1;
CKO_f=10;
CKO_n=1;
Df=CKO_f*CKO_f;
Dn=CKO_n*CKO_n;

D(1)=eye(1);
Dv(1)=eye(1);

xV(1)=10;
xT2(1)=10;

for i=2:num
    xV(i)=F*xT2(i-1);
    Dv(i)=F*D(i-1)*F'+G*Df*G';
    K(i)=Dv(i)*H'*(H*Dv(i)*H'+Dn)^-1;
    D(i)=(1-K(i)*H)*Dv(i);
    xT2(i)=xV(i)+K(i)*(x(i)-H*xV(i));
end

figure;
hold on;
plot(x,'b');
plot(xT,'g','LineWidth',1.5);
plot(xT2,'r','LineWidth',1.5);


figure;
delta = R - xT;
delta2 = R - xT2;

hold on;
plot(delta2,'r');
plot(delta,'g');

bbbb=std(delta);
disp(bbbb);
bbbb2=std(delta2);
disp(bbbb2);

figure;

hist(delta2,100);
hold on;
hist(delta,100);

[N,X] = hist(delta,100);
[N1,X1] = hist(delta2,100);
bar(X1,N1,'r');
hold on;
bar(X,N,'g');

