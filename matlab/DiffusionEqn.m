U=1;
z = linspace(0,1,2000);
H = 1;
n = 1:2000;

A=U*H./n/pi*2;
nu=1;


kn = n*pi*sqrt(nu)/H;

for t=logspace(-6,1,100);

S = sin(n'*pi*z);
S = repmat(A',1,2000).*S;

%

S = repmat(exp(-kn'.^2*t),1,2000).*S;


u = U*H*z-fliplr(sum(S));

plot(u,z)
hold on;
end