function xT = kalman1(y,CKO_f,CKO_n,T,num)
Df=CKO_f*CKO_f;
Dn=CKO_n*CKO_n;

F=1;
G=T;
H=1;

D(1)=eye(1);
Dv(1)=eye(1);

xV(1)=10;
xT(1)=10;

for i=2:num
    xV(i)=F*xT(i-1);
    Dv(i)=F*D(i-1)*F'+G*Df*G';
    K(i)=Dv(i)*H'*(H*Dv(i)*H'+Dn)^-1;
    D(i)=(1-K(i)*H)*Dv(i);
    xT(i)=xV(i)+K(i)*(y(i)-H*xV(i));
end
end