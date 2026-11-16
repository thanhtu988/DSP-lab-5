clear;
funcprot(0);

N = 16;
n = 0:N - 1;
d = [1, zeros(1, N - 1)];
a = 0.8;

B = list([1, 3], 1, [0, 0, 0, 0, 0, 0, 1, 1], [1, 0, 2], ..
         0.25 * [1, 6, 1], [2, -1.5], [1, 2, 1], 0.25 * [1, 0.75, 0.125], ..
         [1, -0.5], [1, -a]);
A = list([1, 3, 2], [1, -1, 0.5], [1, -1], [1, 0, 1], ..
         conv([1, -2, 2], [1, -0.5]), [1, -1.5, 0.5], [1, 4, 4], ..
         conv([1, -0.5], [1, -1, 0.5]), [1, 0.5], [-a, 1]);

X = list();
X(1) = 2 * (-1) .^ n - (-2) .^ n;
X(2) = sqrt(2) * (1 / sqrt(2)) .^ n .* sin((n + 1) * %pi / 4);
X(3) = bool2s(n >= 6) + bool2s(n >= 7);
X(4) = 2 * d - cos(%pi * n / 2);
X(5) = 0.85 * 0.5 .^ n + sqrt(2) .^ n .* (-0.6 * cos(%pi * n / 4) + 2.3 * sin(%pi * n / 4));
X(6) = 1 + 0.5 .^ n;
X(7) = 0.25 * d + 0.25 * (n + 3) .* (-2) .^ n;
X(8) = 0.75 * 0.5 .^ n + (1 / sqrt(2)) .^ n .* (-0.5 * cos(%pi * n / 4) + 0.875 * sin(%pi * n / 4));
X(9) = -d + 2 * (-0.5) .^ n;
X(10) = -a * d + (a ^ 2 - 1) * a .^ (-n - 1);

names = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"];

disp("3.14(h): zeros and poles from Figure P3.14");
disp("zeros = ");  disp(roots([1, 0.75, 0.125, 0]));
disp("poles = ");  disp(roots(conv([1, -0.5], [1, -1, 0.5])));

disp("3.14: closed form vs long division (filter), n = 0..15");
for i = 1:10
    b = B(i) / A(i)(1);
    den = A(i) / A(i)(1);
    xf = filter(b, den, d);
    err = max(abs(xf - X(i))) / max(1, max(abs(X(i))));
    mprintf("(%s)  x(0..7) = [%s]   rel. error = %.2e\n", names(i), ..
            strcat(msprintf("%.4g\n", xf(1:8)'), ", "), err);
end

k = 0:7;
for i = 1:10
    if i == 1 | i == 6 then
        scf(1 + (i > 5));
        clf();
    end
    b = B(i) / A(i)(1);
    den = A(i) / A(i)(1);
    xf = filter(b, den, d);
    subplot(5, 1, i - 5 * (i > 5));
    plot([k; k], [zeros(1, 8); xf(1:8)], "b");
    plot(k, xf(1:8), "bo");
    plot(k, X(i)(1:8), "r+");
    plot([-1, 8], [0, 0], "k");
    ax = gca();
    r = max(abs(xf(1:8)));
    ax.data_bounds = [-1, min([xf(1:8), 0]) - 0.15 * r; 8, max([xf(1:8), 0]) + 0.15 * r];
    xgrid();
    xtitle("3.14(" + names(i) + ")", "", "x(n)");
end
