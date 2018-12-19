N=10;
l=0.4;
T=N/2+N*l/4;
my=1/T;
lja=1/N;
q=my/(my+lja);
A=lja*q;
dt=0.1;
eps=0.0001;
t=0;
P0=[];
P1=[];
tm=[];
k=1;
while(abs(P(0,t)-P(0,t+dt))>eps||abs(P(1,t)-P(1,t+dt))>eps)
    P0(k)=P(0,t);
    P1(k)=P(1,t);
    tm(k)=t;
    k=k+1;
    t=t+dt;
end
disp(t);
r=abs(P0(k-1)-q);
disp(r);
