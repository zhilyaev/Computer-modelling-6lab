function [y] = P(i,t)
N=11;
l=0.3;
T=N/2+N*l/4;
my=1/T;
lja=1/N;
y=0;
if(i==0)
    y=my/(my+lja)+lja/(my+lja)*exp(-t*(lja+my));
end
if(i==1)
    y=lja/(my+lja)-lja/(my+lja)*exp(-t*(lja+my));
end
end