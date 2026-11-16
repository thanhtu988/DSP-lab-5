clc; clear;

r = 0.8;
w0 = %pi/4;

z = poly(0, "z");
X1 = syslin("d", r*sin(w0)*z, z^2 - 2*r*cos(w0)*z + r^2);
p = roots(X1.den);
zr = roots(X1.num);
disp("Cac cuc cua X1(z):"); disp(p);
disp("Do lon |p| va goc (rad) cua cuc:"); disp([abs(p) atan(imag(p), real(p))]);
disp("Khong cua X1(z):"); disp(zr);

scf(0); clf;
plzr(X1);
title("Gian do cuc - khong cua X1(z), r = 0.8, w0 = pi/4");
xs2png(gcf(), "BT3_20_pz.png");

N = 30;
n = 0:N-1;
d = [1 zeros(1, N-1)];
x1 = r.^n .* sin(w0*n);
x1_sim = filter([0 r*sin(w0)], [1 -2*r*cos(w0) r^2], d);
x2_sim = filter([0 1], [1 -2*r*cos(w0) r^2], d);

disp("Sai so giua x1(n) va dap ung cua X1(z) = " + string(max(abs(x1 - x1_sim))));
k = find(abs(x2_sim) > 1e-10);
tile = x1_sim(k) ./ x2_sim(k);
disp("Ti so x1(n)/x2(n) tai cac n co x2(n) khac 0:"); disp(tile(1:6));
disp("r*sin(w0) = " + string(r*sin(w0)));

scf(1); clf;
subplot(2,1,1);
plot2d3(n, x1_sim);
plot(n, x1, "r*");
a = gca(); a.data_bounds = [-1 -0.4; 30 0.8];
title("x1(n) = r^n sin(w0 n) u(n): tu X1(z) (vach) va cong thuc (*)");
xlabel("n");
subplot(2,1,2);
plot2d3(n, x2_sim);
plot(n, x2_sim, "bo");
a = gca(); a.data_bounds = [-1 -0.6; 30 1.3];
title("x2(n) = Z^-1{X2(z)}, G = 1 (x1(n) = r sin(w0) x2(n))");
xlabel("n");
xs2png(gcf(), "BT3_20_xn.png");
