clc; clear;

function X = ZT(x, z)
    n = 0:length(x)-1;
    X = sum(x .* z.^(-n));
endfunction

x = [1+2*%i, 3-%i, -2*%i, 4, 1+%i];
n = 0:length(x)-1;
z0 = 1.5*exp(%i*%pi/5);
w0 = %pi/3;

VT1 = ZT(conj(x), z0);
VP1 = conj(ZT(x, conj(z0)));

VT2 = ZT(real(x), z0);
VP2 = 0.5*(ZT(x, z0) + conj(ZT(x, conj(z0))));

VT3 = ZT(imag(x), z0);
VP3 = (ZT(x, z0) - conj(ZT(x, conj(z0))))/(2*%i);

VT4 = ZT(exp(%i*w0*n).*x, z0);
VP4 = ZT(x, z0*exp(-%i*w0));

disp("Tinh chat 1: VT, VP:"); disp([VT1 VP1]);
disp("Tinh chat 2: VT, VP:"); disp([VT2 VP2]);
disp("Tinh chat 3: VT, VP:"); disp([VT3 VP3]);
disp("Tinh chat 4: VT, VP:"); disp([VT4 VP4]);
saiso = abs([VT1-VP1, VT2-VP2, VT3-VP3, VT4-VP4]);
disp("Sai so |VT - VP| cua 4 tinh chat:");
disp(saiso);
