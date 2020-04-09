S_0 = 0.9;
I_0 = 0.1;
ALPHA = 2;
MU = 0.5;
PERIODS = 20;

s(1) = S_0;
i(1) = I_0;

for n = 2:PERIODS
    deltaS = compute_S_at_n(s(n - 1), i(n - 1), ALPHA, n);
    deltaI = compute_I_at_n(s(n - 1), i(n - 1), ALPHA, MU, n);
    newS = s(n - 1) + deltaS;
    
    if newS < 0
        newS = 0;
    end
    
    s(n) = newS;
    i(n) = i(n - 1) + deltaI;
end

close all
figure;
x = [1:PERIODS];
plot(x, s);
hold on
plot(x, i);


function s = compute_S_at_n(prevS, prevI, a, n)
    s = -a * prevS * prevI;
end

function i = compute_I_at_n(prevS, prevI, a, m, n)
    i = a * prevS * prevI - m * prevI;
end