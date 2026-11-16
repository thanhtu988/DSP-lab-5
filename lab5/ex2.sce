clc; clear;

x1 = [1 2 3 4 5];
x2 = [1 1 1];
ya = conv(x1, x2);
na = 0:length(ya)-1;
disp("Cau a: y(n) = ");
disp(ya);

N = 10;
n = 0:N-1;
x1 = (1/5).^n;
x2 = 2.^n;
yb = conv(x1, x2);
yb = yb(1:N);
yb_ct = (10/9)*2.^n - (1/9)*(1/5).^n;
disp("Cau b: y(n) tu conv() va tu cong thuc:");
disp([n' yb' yb_ct']);
disp("Sai so lon nhat cau b = " + string(max(abs(yb - yb_ct))));

x1 = n;
x2 = 2.^n;
x2(1) = 0;
yc = conv(x1, x2);
yc = yc(1:N);
yc_ct = (2.^(n+1) - 2*n - 2);
disp("Cau c: y(n) tu conv() va tu cong thuc:");
disp([n' yc' yc_ct']);
disp("Sai so lon nhat cau c = " + string(max(abs(yc - yc_ct))));

scf(0); clf;
subplot(3,1,1);
plot2d3(na, ya);
plot(na, ya, "bo");
a = gca(); a.data_bounds = [-0.5 0; 6.5 14];
title("Cau a: y(n) = x1(n) * x2(n)");
xlabel("n"); ylabel("y(n)");

subplot(3,1,2);
plot2d3(n, yb);
plot(n, yb_ct, "r*");
a = gca(); a.data_bounds = [-0.5 0; 9.5 600];
title("Cau b: conv() (vach) va cong thuc (*)");
xlabel("n"); ylabel("y(n)");

subplot(3,1,3);
plot2d3(n, yc);
plot(n, yc_ct, "r*");
a = gca(); a.data_bounds = [-0.5 0; 9.5 1100];
title("Cau c: conv() (vach) va cong thuc (*)");
xlabel("n"); ylabel("y(n)");

xs2png(gcf(), "Ex2.png");
