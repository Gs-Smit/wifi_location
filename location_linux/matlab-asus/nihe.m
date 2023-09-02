clear all;

x=[1 2 3 4];
y=[1.1 2.2 2.7 3.8];

pn=polyfit(x,y,1);
 
yy=polyval(pn,x);
subplot(1,2,1);
plot(x,y);
subplot(1,2,2);
plot(x,yy);