clear all
POPULATION = 8000000;
I_0 = 5 / POPULATION;
%I_0 = 8000 / POPULATION;
S_0 = 1 - I_0;
ALPHA = 1.5;
MU = 0.6;
PERIODS = 400;
S_VARIATION = 100 / POPULATION;
STOP_SIM = 6; % stop simulation after s remains unchanged

s(1) = S_0; % susceptible 
i(1) = I_0; % infected
r(1) = 0;   % recovered or died
stop = 0;

for n = 2:PERIODS
    deltaS = compute_S_at_n(s(n - 1), i(n - 1), ALPHA);
    deltaI = compute_I_at_n(s(n - 1), i(n - 1), ALPHA, MU);
    
    s(n) = s(n - 1) + deltaS;
    i(n) = i(n - 1) + deltaI;
    %r(n) = S_0 - s(n) - i(n);
    r(n) = r(n - 1) + MU * i(n - 1);
    
    if s(n - 1) - s(n) <= S_VARIATION
        stop = stop + 1;
    else
        stop = 0;
    end
    
    if stop >= STOP_SIM
        break;
    end

end

s = s .* POPULATION;
i = i .* POPULATION;
r = r .* POPULATION;

close all
f = figure(1);
x = [1:size(s, 2)];
pl(1) = plot(x, s);
hold on
pl(2) = plot(x, i);
pl(3) = plot(x, r);
h = legend(pl,'susceptible','infected','recovered or died');
title([sprintf('SIR model\n') 'alpha: ' mat2str(ALPHA) ' mu: ' mat2str(MU)], 'fontsize', 18);
ax = ancestor(pl(1), 'axes');
ax.YAxis.Exponent = 0;
ytickformat('%d');
grid;


function s = compute_S_at_n(prevS, prevI, a)
    s = -a * prevS * prevI;
end

function i = compute_I_at_n(prevS, prevI, a, m)
    i = a * prevS * prevI - m * prevI;
end