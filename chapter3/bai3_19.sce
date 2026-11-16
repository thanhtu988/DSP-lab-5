clear;
funcprot(0);

function draw_sig(n, x, ttl)
    plot([n; n], [zeros(1, length(x)); x], "b");
    plot(n, x, "bo");
    plot([min(n) - 1, max(n) + 1], [0, 0], "k");
    a = gca();
    a.data_bounds = [min(n) - 1, min([x, 0]) - 0.5; max(n) + 1, max([x, 0]) + 0.5];
    xgrid();
    xtitle(ttl, "n", "amplitude");
endfunction

K = 200;

disp("3.19(a): X(z) = log(1 - 2z), |z| < 1/2  ->  x(n) = 2^(-n)/n, n <= -1");
na = -K:-1;
xa = (2 .^ (-na)) ./ na;
z0 = 0.2;
disp("sum x(n) z0^(-n) = ");  disp(sum(xa .* z0 .^ (-na)));
disp("log(1 - 2 z0)    = ");  disp(log(1 - 2 * z0));
disp("n x(n) for n = -1..-5 (should be 0.5^n) = ");  disp(na($:-1:$-4) .* xa($:-1:$-4));

disp("3.19(b): X(z) = log(1 - z^-1)  ->  x(n) = -u(n-1)/n");
nb = 1:K;
xb = -1 ./ nb;
z1 = 2;
disp("sum x(n) z1^(-n) = ");  disp(sum(xb .* z1 .^ (-nb)));
disp("log(1 - 1/z1)    = ");  disp(log(1 - 1 / z1));
disp("partial sums at z = 0.75 (inside 1/2 < |z| < 1), K = 20, 40, 80:");
for KK = [20, 40, 80]
    mprintf("  K = %d : %.4f\n", KK, sum(xb(1:KK) .* 0.75 .^ (-nb(1:KK))));
end

scf(1);
clf();
subplot(2, 1, 1);
draw_sig(-10:-1, xa($-9:$), "3.19(a): x(n) = 2^(-n)/n, n <= -1");
subplot(2, 1, 2);
draw_sig(1:10, xb(1:10), "3.19(b): x(n) = -u(n-1)/n");
