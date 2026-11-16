clc; clear;

N = 20;
n = 0:N-1;
b = 1;
a = [1 -0.7];

d = [1 zeros(1, N-1)];
h = filter(b, a, d);
h_ct = 0.7.^n;
disp("Cau b: h(n) mo phong va h(n) = 0.7^n u(n):");
disp([n' h' h_ct']);
disp("Sai so lon nhat cau b = " + string(max(abs(h - h_ct))));

u = ones(1, N);
y = filter(b, a, u);
y_ct = 10/3 - (7/3)*0.7.^n;
disp("Cau c: y(n) mo phong va y(n) = [10/3 - 7/3*0.7^n] u(n):");
disp([n' y' y_ct']);
disp("Sai so lon nhat cau c = " + string(max(abs(y - y_ct))));

scf(0); clf;
subplot(2,1,1);
plot2d3(n, h);
plot(n, h_ct, "r*");
a = gca(); a.data_bounds = [-0.5 0; 19.5 1.1];
title("Cau b: h(n) - filter() (vach) va 0.7^n (*)");
xlabel("n"); ylabel("h(n)");

subplot(2,1,2);
plot2d3(n, y);
plot(n, y_ct, "r*");
plot(n, (10/3)*ones(1, N), "k--");
a = gca(); a.data_bounds = [-0.5 0; 19.5 3.6];
title("Cau c: y(n) voi x(n) = u(n), tien ve 10/3");
xlabel("n"); ylabel("y(n)");

xs2png(gcf(), "Ex4.png");
