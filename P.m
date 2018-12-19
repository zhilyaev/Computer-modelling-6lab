function [y] = P(i, t, mu, l)
y=0;
if(i == 0)
     y= mu / (mu+l)+l / (mu+l)*exp(-t*(l+mu));
end
if(i == 1)
    y = l / (mu+l)-l / (mu+l)*exp(-t*(l+mu));
end
end
