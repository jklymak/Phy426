function u = biharm(u,fac);

if nargin<2
  fac = 100;
end;
d4 = diff(diff(diff(diff(u))));

u(3:end-2)= u(3:end-2)-(d4)/fac;

if 0
if max(abs(d4/fac))>0.02
clf
plot(d4/fac);
hold on;
plot(u)
ppause
end
end

