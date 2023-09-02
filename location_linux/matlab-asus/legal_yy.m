function ret=legal_yy(x,y)

k1=1;
len=length(x);
diffe1=diff(x);
diffe2=diff(y).';
temp=zeros(1,len-1);
for i=1:len-1
    temp(i)=diffe2(i)/diffe1(i);
end
w1=var(temp,1);
if w1<0.00525 %0.00525
    ret=true;
else
    ret=false;
end
end