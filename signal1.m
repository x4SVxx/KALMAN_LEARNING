function y = signal1(length,CKO_f,CKO_n,T,num)
    R(1)=length;
    for i=2:num
        R(i)=R(i-1)+T*normrnd(0,CKO_f);
    end
    y=R+normrnd(0,CKO_n,[1,num]);
end

