clear E KE PE dt inE outE


x = -600:1:600;
x = x/4;
t = 1:15000;
%u = 0*t'*x;
%h = 0*t'*x;
u = x*0;
h = x*0;
b = 10*exp(-(x-mean(x)).^2/30^2);

h(1,:) = (15-b);
h0=h(1);
%h(2*end/3:end)=0.7*h(2*end/3:end);
g = 980;
Fo = 1.5;
Q = Fo*h(1,1)^(3/2)*sqrt(g);

u(1,:)=Q./h(1,1);
u =0*x;;
u(1:10) = Q./h(1);
u(end-9:end) = Q./h(1);



% lam = 0.005;
for i=1:length(t)-1;
  i
  lam = 0.4/(max(u)+sqrt(g*max(h)));
  m = h.*u;
  ph = h;
  W = [m;ph];
  G = [m.^2./ph+g*ph.^2/2;m];
  clear A
  A11 = 2*m./ph;
  A12 = g*ph-m.^2./ph.^2;
  A21= 0*x+1;
  A22=  0*x;
  
  Wn=W;
  Wn(:,2:end-1) = Wn(:,2:end-1)-lam*0.5*(G(:,3:end)-G(:,1:end-2));
  Z = 0*W(1,:);
  Wn(:,2:end-1) = Wn(:,2:end-1)-[lam*0.5*(b(:,3:end)-b(:,1:end-2))*g.*ph(2:end-1);Z(2:end-1)];
  A = Z;
  A(2:end-1) = 0.5*(A11(3:end)+A11(2:end-1));
  Wn(1,2:end-1) = Wn(1,2:end-1)+0.5*lam.^2*(A(2:end-1).*(G(1,3:end)-G(1,2:end-1)));
  Wn(1,2:end-1) = Wn(1,2:end-1)+0.5*lam.^2*(A(2:end-1).*g.*0.5.*(ph(3:end)+ph(2:end-1)).*(b(3:end)-b(2:end-1)));
  A(2:end-1) = 0.5*(A12(3:end)+A12(2:end-1));
  Wn(1,2:end-1) = Wn(1,2:end-1)+0.5*lam.^2*(A(2:end-1).*(G(2,3:end)-G(2,2:end-1)));
  
  Wn(2,2:end-1) = Wn(2,2:end-1)+0.5*lam.^2*((G(2,3:end)-G(2,2:end-1)));
  Wn(2,2:end-1) = Wn(2,2:end-1)+0.5*lam.^2*(g.*0.5*(ph(3:end)+ph(2:end-1)).*(b(3:end)-b(2:end-1)));
  
  % minus terms...
  A(2:end-1) = 0.5*(A11(2:end-1)+A11(1:end-2));
  Wn(1,2:end-1) = Wn(1,2:end-1)-0.5*lam.^2*(A(2:end-1).*(G(1,2:end-1)-G(1,1:end-2)));
  Wn(1,2:end-1) = Wn(1,2:end-1)-0.5*lam.^2*(A(2:end-1).*g.*0.5.*(ph(2:end-1)+ph(1:end-2)).*(b(2:end-1)-b(1:end-2)));
  A(2:end-1) = 0.5*(A12(2:end-1)+A12(1:end-2));
  Wn(1,2:end-1) = Wn(1,2:end-1)-0.5*lam.^2*(A(2:end-1).*(G(2,2:end-1)-G(2,1:end-2)));
  
  Wn(2,2:end-1) = Wn(2,2:end-1)-0.5*lam.^2*((G(2,2:end-1)-G(2,1:end-2)));
  Wn(2,2:end-1) = Wn(2,2:end-1)-0.5*lam.^2*(g.*0.5*(ph(3:end)+ph(2:end-1)).*(b(2:end-1)-b(1:end-2)));
  
  Wn(1,2:end-1) = Wn(1,2:end-1)+lam^2/2*(0.5*0.5*g*(b(3:end)-b(1:end-2)).*(m(3:end)-m(1:end-2)));
  
  
%   
%   for j=2:length(x)-1;
%     A = [A1(:,j)';A2(:,j)'];
%     Ap = 0.5*[A1(:,j+1)'+A1(1,j)';A2(:,j+1)'+A2(1,j)'];
%     Am = 0.5*[A1(:,j-1)'+A1(1,j)';A2(:,j-1)'+A2(1,j)'];
%     
%     Wn(:,j)= W(:,j);
%     K = [g*ph(j)*0.5*(b(j+1)-b(j-1));0];
%     Wn(:,j) = Wn(:,j)-lam*K;
%     Wn(:,j) = Wn(:,j)-lam*0.5*(G(:,j+1)-G(:,j-1));
%     Wn(:,j) = Wn(:,j)+lam^2/2*[g*0.5*(b(j+1)-b(j-1))*0.5*(m(j+1)-m(j-1));0];
%     K = [g*0.5*(ph(j+1)+ph(j));0];
%     
%     Wn(:,j) = Wn(:,j)+lam^2/2*(Ap*(G(:,j+1)-G(:,j)+K));
% 
%     K = [g*0.5*(ph(j-1)+ph(j));0];
%     Wn(:,j) = Wn(:,j)-lam^2/2*(Am*(G(:,j)-G(:,j-1)+K));
%     
%     
%   end;
  W=Wn;
  h=Wn(2,:);
  u=Wn(1,:)./h;
  h(1) = h(2)+h(2)-h(3);
%  h(end-1) = h(end-2);
  h(end) = h(end-1)+h(end-1)-h(end-2);
  u(1) = Q./h(1)*min(1,i/400);
  u(end) = Q./h(end)*min(1,i/400);
  if mod(i,1)==0
    h=conv2(h,ones(1,3)/3,'same');
    u=conv2(u,ones(1,3)/3,'same');
  end;
  
  h(1) = h(2)+h(2)-h(3);
%  h(end-1) = h(end-2);
  h(end) = h(end-1)+h(end-1)-h(end-2);
  u(1) = Q./h(1)*min(1,i/400);
  u(end) = Q./h(end)*min(1,i/400);
  %  sponge layer
  
  gam = 1./[3:32];
  gam = gam;
  u(1:30)= u(1:30)-gam.*(u(1:30)-Q./h(1)*min(1,i/400));
  h(1:30)= h(1:30)-gam.*(h(1:30)-h0);
  
 
  gam = fliplr(gam);
  u(end-29:end)= u(end-29:end)-gam.*(u(end-29:end)-Q./h(end)*min(1,i/400));
  h(end-29:end)= h(end-29:end)-gam.*(h(end-29:end)-h0);
  
  ini = find(x>0);ini=ini(1);
  outi = find(x>45);outi=outi(1);
  KE = 0.5*h.*u.^3;
  PE = (h+b).*h*g.*u;
    
  inE(i) = KE(ini)+PE(ini);
  outE(i) = KE(outi)+PE(outi);
  in = find(x>0&x<45);
  E(i) = sum(0.5*d(in).*u(in).^2+0.5*g.*d(in).^2);
  dt(i) = lam;
  if mod(i,20)==0
    clf
    figure(1);
    subplot3(3,1,1);
  
    plot(x,h+b,'linewi',1.5);
    hold on;
    plot(x,b,'linewi',3);
    set(gca,'ylim',[0 2]*30,'xlim',[-200 200]);
    ylabel('z [cm]');

    subplot3(3,1,2);
    plot(x,u,'linewi',1.5);
    ylabel('U [cm/s]');
    set(gca,'ylim',[0 30]*10,'xlim',[-200 200]);
%    subplot3(3,1,3);
%    plot(x,u.*h);
    subplot3(3,1,3);
    
    
     plot(x,KE/1e5,x,PE/1e5,x,(KE+PE)/1e5,'linewi',1.5);
 %    plot(x,u.*h,'linewi',1.5);
     set(gca,'xlim',[-200 200]);
    suptitle(int2str(i))
    drawnow;
    
    
    
  end;
end;

%%
figure(2);
clf
plot(cumsum(dt),inE-outE-diffsame(E)./dt,'g')
hold on
plot(cumsum(dt),diffsame(E)./dt,'r')
plot(cumsum(dt),inE-outE)
legend('\epsilon','dE/dt','\Delta uB')
title('Energy balance: 0 -- 45 cm');

