function xT = kalman2(y,CKO_f,CKO_n,T,num)
Df=CKO_f*CKO_f;
Dn=CKO_n*CKO_n;

F=[1,T;0,1];
G=[0;T];
H=[1,0];
I=eye(2);

Dm=eye(2);
D(:,:,1)=Dm;
Dvm=eye(2);
Dv(:,:,1)=Dvm;

xVv=[10;1];
xTv=[10;1];
xV(:,1)=xVv;
xT(:,1)=xTv;

for i=2:num
    xV(:,i)=F*xT(:,i-1);
    Dv(:,:,i)=F*D(:,:,i-1)*F'+G*Df*G';
    K(:,i)=Dv(:,:,i)*H'*(H*Dv(:,:,i)*H'+Dn)^-1;
    D(:,:,i)=(I-K(:,i)*H)*Dv(:,:,i);
    xT(:,i)=xV(:,i)+K(i)*(y(i)-H*xV(:,i));
end
xT = H*xT;
end

