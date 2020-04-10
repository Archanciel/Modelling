S_0 = 0.99;
I_0 = 0.01;
ALPHA = 1.5;
MU = 0.6;
PERIODS = 20;

s(1) = S_0; % susceptible 
i(1) = I_0; % infected
r(1) = 0;   % recovered or died

% susceptible function

syms prevS prevI a;

y_s = -a * prevS * prevI;
vpa(y_s)

% infected function

syms m;

y_i = a * prevS * prevI - m * prevI;
vpa(y_i)

for n = 2:PERIODS
    deltaS = subs(y_s, [prevS, prevI, a], [s(n - 1), i(n - 1), ALPHA]);
    deltaI = subs(y_i, [prevS, prevI, a, m], [s(n - 1), i(n - 1), ALPHA, MU]);;
    newS = s(n - 1) + deltaS;
    
    if newS < 0
        newS = 0;
    end
    
    s(n) = newS;
    i(n) = i(n - 1) + deltaI;
    r(n) = S_0 - s(n) - i(n);
end

close all
figure;
x = [1:PERIODS];
pl(1) = plot(x, s);
hold on
pl(2) = plot(x, i);
pl(3) = plot(x, r);
h = legend(pl,'susceptible','infected','recovered or died');
title([sprintf('SIR model\n') 'alpha: ' mat2str(ALPHA) ' mu: ' mat2str(MU)], 'fontsize', 18);
grid;
