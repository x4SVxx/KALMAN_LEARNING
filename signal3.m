function y = signal3(length,speed,acceleration,CKO_f,CKO_n,T,num)
    F=[1,T,T;0,1,T;0,0,1];
    G=[0;0;T];
    H=[1,0,0];
    
    R(1)=length;
    V(1)=speed;
    a(1)=acceleration;
    for i=2:num
        R(i)=R(i-1)+T*V(i-1);
        V(i)=V(i-1)+T*a(i-1);
        a(i)=a(i-1)+T*normrnd(0,CKO_f);
    end
    x = [R;V;a];
    for i=2:num
        x(:,i)=F*x(:,i-1)+G*normrnd(0,CKO_f);
    end
    y=H*x+normrnd(0,CKO_n,[1,num]);
end


