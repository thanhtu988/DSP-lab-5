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

function X = zt(x, z)
    X = sum(x .* z .^ (-(0:length(x) - 1)));
endfunction

N = 200;
n = 0:N - 1;
x = (0.5) .^ n;
z0 = 1.5;

disp("Example: x(n) = 0.5^n u(n),  X(z) = 1/(1 - 0.5 z^-1),  |z| > 0.5");

x1 = zeros(1, 2 * N);
x1(1:2:$) = x;
disp("3.13(a): X1(z) = X(z^2)");
disp("X1(z0) by definition = ");  disp(zt(x1, z0));
disp("X(z0^2)              = ");  disp(zt(x, z0 ^ 2));
d = [1, zeros(1, 15)];
x1f = filter(1, [1, 0, -0.5], d);
disp("first samples of x1(n)          = ");  disp(x1(1:8));
disp("IZT of X(z^2) = 1/(1-0.5z^-2)   = ");  disp(x1f(1:8));

x2 = x(1:2:$);
disp("3.13(b): X2(z) = [X(z^(1/2)) + X(-z^(1/2))] / 2");
disp("X2(z0) by definition = ");  disp(zt(x2, z0));
disp("formula              = ");  disp((zt(x, sqrt(z0)) + zt(x, -sqrt(z0))) / 2);
x2f = filter(1, [1, -0.25], d);
disp("first samples of x2(n) = x(2n)  = ");  disp(x2(1:8));
disp("IZT of 1/(1-0.25z^-1)           = ");  disp(x2f(1:8));

k = 0:10;
scf(1);
clf();
subplot(3, 1, 1);
draw_sig(k, x(1:11), "x(n) = 0.5^n u(n)");
subplot(3, 1, 2);
draw_sig(k, x1(1:11), "x1(n) = x(n/2) (n even), 0 (n odd)");
subplot(3, 1, 3);
draw_sig(k, x2(1:11), "x2(n) = x(2n)");
