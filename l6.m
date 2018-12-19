clear, clc
N=4;
l=0;
if(mod(N,2) == 0)
    l = 0.4;
else
    l = 0.3;
end
hour = 60;
dt= 0.1 / hour;
eps=0.0001;

%t_Obs = N/2 +N*1/4*l; % time for serve
t_Obs = 2.3;
%lam= 1 / N;% intensive stream order
lam = 18;
mu = hour / t_Obs; % intensive stream service
q = mu / (mu+lam); % static mode
P_otk = 1 - q; % reject
A= lam * q; % abs bandwith
p = lam*t_Obs;% intensive highload
P0=[];
P1=[];
tm=[];
t=0;
k=1;

stan_point = 0;

is_end = true;
count = 0;
fprintf('   dt\tP0(t)\tP1(t)\n');
while(is_end || count < 50)
    P0(k)=P(0,t,mu,lam);
    P1(k)=P(1,t,mu,lam);
    tm(k)=t;
    fprintf('%.4f %.4f %.4f\n',t, P0(k), P1(k));
    k=k+1;
    t=t+dt;
    
    if(abs(P(0,t,mu,lam)-P(0,t+dt,mu,lam))>eps||abs(P(1,t,mu,lam)-P(1,t+dt,mu,lam))>eps)
        is_end = true;
        stan_point = k;
    else
        is_end = false;
        count = count + 1;
    end
end

figure
plot(tm,P0);
hold on
plot(tm(stan_point-1),P0(stan_point-1),'r*') 
title(['Mu=', num2str(mu), ' lam=', num2str(lam), ' A=', num2str(A)])
p0 = 1-P_otk; % chance that chanel is free
r=abs(P0(k-1)-q); 
fprintf('time: %.4f\n', t);
fprintf('Bandwidth:%.4f\n', A);
fprintf('reject:%.4f%%\n', P_otk);
fprintf('chanel dont busy:%.4f%% \n', p0);
fprintf('time for serve order: %.4f\n', t_Obs);
fprintf('diff emulate and analitics q:%.4f\n', r);
numberOfOperators = 4;
precision = ((p/60)^numberOfOperators)/factorial(numberOfOperators)*p0;
fprintf('~Bandwidth = %.4f%% if count of operatiors = %d\n', 1- precision, numberOfOperators)

