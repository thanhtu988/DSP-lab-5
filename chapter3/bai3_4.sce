clc; clear;

function X = ZT(x, n, z)
    X = sum(x .* z.^(-n));
endfunction

z0 = 1.5;
n = 0:300;

xa = n .* (-1).^n;
Xa = ZT(xa, n, z0);
Xa_ct = -z0^(-1)/(1 + z0^(-1))^2;

xb = n.^2;
Xb = ZT(xb, n, z0);
Xb_ct = z0^(-1)*(1 + z0^(-1))/(1 - z0^(-1))^3;

a = 2;
m = -300:-1;
xc = -m .* a.^m;
Xc = ZT(xc, m, z0);
Xc_ct = a*z0^(-1)/(1 - a*z0^(-1))^2;

xd = (-1).^n .* cos(%pi*n/3);
Xd = ZT(xd, n, z0);
Xd_ct = (1 + 0.5*z0^(-1))/(1 + z0^(-1) + z0^(-2));

xe = (-1).^n;
Xe = ZT(xe, n, z0);
Xe_ct = 1/(1 + z0^(-1));

xf = round(cos(%pi*n/2));
Xf = ZT(xf, n, z0);
Xf_ct = 1/(1 + z0^(-2));

ten = ["a"; "b"; "c"; "d"; "e"; "f"];
TS = [Xa; Xb; Xc; Xd; Xe; Xf];
CT = [Xa_ct; Xb_ct; Xc_ct; Xd_ct; Xe_ct; Xf_ct];
mprintf("Kiem tra tai z0 = %g\n", z0);
mprintf("Cau   Tong sum x(n)z^-n    Cong thuc X(z0)    Sai so\n");
for k = 1:6
    mprintf("%s     %14.8f     %14.8f     %e\n", ten(k), TS(k), CT(k), abs(TS(k)-CT(k)));
end

k = -3:15;
u = bool2s(k >= 0);
scf(0); clf;
subplot(3,2,1); x = k.*(-1).^k.*u;
plot2d3(k, x); plot(k, x, "bo"); title("a) n(-1)^n u(n)");
subplot(3,2,2); x = k.^2.*u;
plot2d3(k, x); plot(k, x, "bo"); title("b) n^2 u(n)");
kk = -15:3;
subplot(3,2,3); x = -kk.*a.^kk.*bool2s(kk <= -1);
plot2d3(kk, x); plot(kk, x, "bo"); title("c) -n a^n u(-n-1), a = 2");
subplot(3,2,4); x = (-1).^k.*cos(%pi*k/3).*u;
plot2d3(k, x); plot(k, x, "bo"); title("d) (-1)^n cos(pi n/3) u(n)");
subplot(3,2,5); x = (-1).^k.*u;
plot2d3(k, x); plot(k, x, "bo"); title("e) (-1)^n u(n)");
subplot(3,2,6); x = round(cos(%pi*k/2)).*u;
plot2d3(k, x); plot(k, x, "bo"); title("f) {1,0,-1,0,1,0,-1,...}");

xs2png(gcf(), "BT3_4.png");
