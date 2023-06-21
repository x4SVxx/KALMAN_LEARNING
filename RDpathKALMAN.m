% clear all;
% load('измерения.mat');

sizeSatPos=size(SatPos);
beacons=sizeSatPos(1,2);
massivesizeR=size(R);
sizeR=massivesizeR(1,2);

CKO_f=0.4;
CKO_n=0.3;
num=sizeR;
Df=CKO_f^2*eye(2);

T=0.1;
F=[1,0;0,1];
G=[T,0;0,T];
D(:,:,1)=eye(2);
Dv(:,:,1)=eye(2);
xV(:,1)=[0;0];
xT(:,1)=[2;2];

for i=2:num
    schet=0;
    for count=1:beacons
        if R(count,i)~=0
            schet=schet+1;
            massivecount(schet)=count;
            if count==beacons
                flagRD=1;
            end
        end
    end
    if flagRD==1
        for count=1:schet
            trueR(count)=R(massivecount(count),i);
        end

        for count=1:schet-1
            TtrueR(count)=trueR(count)-trueR(schet);
        end

        Dn=CKO_n^2*eye(schet-1);

        xV(:,i)=F*xT(:,i-1);
        j=1;
        while j<=schet-1
            h(j,1)=((xV(1,i)-SatPos(1,j))/(sqrt(((xV(1,i)-SatPos(1,j))^2)+((xV(2,i)-SatPos(2,j))^2))))-((xV(1,i)-SatPos(1,schet))/(sqrt(((xV(1,i)-SatPos(1,schet))^2)+((xV(1,i)-SatPos(2,schet))^2))));
            h(j,2)=((xV(2,i)-SatPos(2,j))/(sqrt(((xV(1,i)-SatPos(1,j))^2)+((xV(2,i)-SatPos(2,j))^2))))-((xV(2,i)-SatPos(2,schet))/(sqrt(((xV(1,i)-SatPos(1,schet))^2)+((xV(1,i)-SatPos(2,schet))^2))));
            s(j)=TtrueR(j);
            sv(j)=sqrt((xV(1,i)-SatPos(1,j))^2+(xV(2,i)-SatPos(2,j))^2)-sqrt((xV(1,i)-SatPos(1,schet))^2+(xV(2,i)-SatPos(2,schet))^2);
            j=j+1;
        end
        y=s';
        yv=sv';  
        Dv(:,:,i)=F*D(:,:,i-1)*F'+G*Df*G';
        K(:,:,i)=Dv(:,:,i)*h'*(h*Dv(:,:,i)*h'+Dn)^-1;
        D(:,:,i)=Dv(:,:,i)-(K(:,:,i)*h*Dv(:,:,i));
        xT(:,i)=xV(:,i)+(K(:,:,i)*(y-yv));

        massivecount=[];
        trueR=[];
        TtrueR=[];
        h=[];
        s=[];
        sv=[];
        y=[];
        yv=[];
        K=[];
    else
        i=i-1;
    end
end
figure;
plot(xT(1,:),xT(2,:),'b','LineWidth',1.5);
% hold on;
% plot(True(1,:),True(2,:),'g','LineWidth',1);