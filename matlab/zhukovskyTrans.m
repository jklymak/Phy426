% Zhukovsky airfol calculations

% Parameters

R = 1;  % radius of sphere in sphere co-ords
U = 2;  % speed of free stream
alp = 2*pi/180;  % angle of attack;
dz = -0.1+0.15*sqrt(-1);  % offset describing airfoil shape.  

% derived
beta = asin(imag(dz)/R);
gammaC = 4*pi*U*R*sin(-alp+beta);
b=R+real(dz);


thet = linspace(0,2*pi,100);
si = R*exp(sqrt(-1)*thet);

si = si+dz;

x = linspace(-8,8,400);
y= linspace(-4,4,200);
[X,Y]=meshgrid(x,y);

z = X+sqrt(-1)*Y;


r = abs(z);
thet = angle(z);

% calculate streamlines for flow around sphere

psi = U*(r-R^2./r).*sin(thet);

% add vortex

gam = gammaC
psi = psi +gam/2/pi*log(r);

% map onto airfoil space

z = z+dz;
z = z*exp(-sqrt(-1)*alp);

% find data from outside the sphere.
out=find(abs(z-dz)>=R);

% figure out where in airfoil-space the co-=ordinates in sphere-space are:
zz = z+b^2./z;
zz = zz*exp(sqrt(-1)*alp);

% interpolate distorted co-ordinate system onto a regular one.
psinew = griddata(real(zz(out)),imag(zz(out)),psi(out),X,Y);

u = diffsame(psinew);
v = diffsame(psinew')';

p = 1000*0.5*(-u.^2-v.^2);

edge=(si+b^2./si)*exp(sqrt(-1)*alp);

inside = inpolygon(X,Y,real(edge),imag(edge));

for i=1:length(x);
  in = find(inside(:,i));
  if ~isempty(in);
    top(i)=p(in(end)+1);
    bot(i) = p(in(1)-1);
    topn(i)=(in(end)+1);
    botn(i) = (in(1)-1);
  else
    top(i)=NaN;
    bot(i)=NaN;
    topn(i)=NaN;
    botn(i)=NaN;
  end;
end;



% calculate the lift...





%%


clf
subplot(2,1,1);
[c,h]=contour(real(z),imag(z),psi,[-6:0.2:6]);
hold on;
plot(si)
axis equal;


subplot(2,1,2)
plot(edge,'r','linewi',2);
hold on;

contour(x,y,psinew,[-6:0.2:6]);
axis equal
