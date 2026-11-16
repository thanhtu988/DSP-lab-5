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

N = 15;
n = 0:N - 1;
d = [1, zeros(1, N - 1)];

disp("3.8(a): y(n) = sum x(k), k <= n  <->  Y(z) = X(z) / (1 - z^-1)");
x = (0.5) .^ n;
y_sum = cumsum(x);
y_z = filter(1, [1, -1], x);
disp("y from cumsum         = ");  disp(y_sum(1:8));
disp("y from X(z)/(1-z^-1)  = ");  disp(y_z(1:8));
disp("error = ");  disp(max(abs(y_sum - y_z)));

disp("3.8(b): x(n) = (n+1)u(n) = u(n)*u(n)  <->  X(z) = 1/(1 - z^-1)^2");
u = ones(1, N);
uu = convol(u, u);
uu = uu(1:N);
xb = filter(1, [1, -2, 1], d);
disp("u(n)*u(n)             = ");  disp(uu(1:8));
disp("IZT of 1/(1-z^-1)^2   = ");  disp(xb(1:8));
disp("(n+1)u(n)             = ");  disp(n(1:8) + 1);
disp("error = ");  disp(max(abs(uu - (n + 1))) + max(abs(xb - (n + 1))));

scf(1);
clf();
subplot(3, 1, 1);
draw_sig(n, u, "u(n)");
subplot(3, 1, 2);
draw_sig(n, uu, "u(n) * u(n)");
subplot(3, 1, 3);
draw_sig(n, xb, "inverse z-transform of 1/(1 - z^-1)^2");
