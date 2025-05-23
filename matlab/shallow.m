clear E outE inE dt


solid = 0;
x = -2000:2000;
x = x/4;
t = 1:10000;
%u = 0*t'*x;
%h = 0*t'*x;
u = x*0;
h = x*0;
b = 15*exp(-(x-mean(x)).^2/60^2);

h(1,:) = (20-b);
%h(end/2:end) = 15-b(end/2:end);
%h = conv2(h,ones(1,10)/10,'sam')

g = 980;
Fo = 0.2;
Q = Fo*h(1,1)^(3/2)*sqrt(g);

u(1,:)=Q./h(1);

lam0 = 0.8/(max(u(400:end-400)+sqrt(g*max(h(400:end-400)))))/20;

% lam = 0.005;
for i=1:length(t)-1;
  lam = max(0.4/(max(u(400:end-400)+sqrt(g*h(400:end-400)))),lam0);
  i
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
  if solid
    h(1) = h(2)+h(2)-h(3);
    h(end-1) = h(end-2);
    h(end) = h(end-1)+h(end-1)-h(end-2);

    u(1) = Q./h(1);
    u(end) = Q./h(end);
  else
    u([1:3])=u([end-2:end]);
    h([1:3])=h([end-2:end]);
  end;
    
  % 
  
  hh = h;
  uu = u;
  u = biharm(u,1e6*lam);
   h = biharm(h,1e6*lam);
 
%  u(2:end-1) = u(2:end-1) - 0.1*lam*diff(diff(u))./diff(x(1:end-1))./diff(x(1:end-1));
  if mod(i,10);
    u=conv2(u,ones(1,3)/3,'same');
  
    h=conv2(h,ones(1,3)/3,'same');
  end
    % [bb,a]=butter(4,0.2);
   
  % h = filtfilt(bb,a,h);
  % u = filtfilt(bb,a,u);
   
   h([1 end])=hh([1 end]);
   u([1 end])=uu([1 end]);
    ini = find(x>0);ini=ini(1);
    outi = find(x>45);outi=outi(1);
    KE = 0.5*h.*u.^3;
    PE = (h+b).*h*g.*u;
    
    inE(i) = KE(ini)+PE(ini);
    outE(i) = KE(outi)+PE(outi);
%    in = find(x>0&x<45);
%    E(i) = sum(0.5*d(in).*u(in).^2+0.5*g.*d(in).^2);
    dt(i) = lam;
  if mod(i,20)==0
    clf
    figure(1);
    subplot3(3,1,1);
  
    plot(x,h+b,'linewi',1.5);
    hold on;
    plot(x,b,'linewi',3);
    set(gca,'ylim',[0 3.5]*10,'xlim',[-200 200]*5/2);
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
     set(gca,'xlim',[-200 200]*5/2);
    suptitle(int2str(i))
    drawnow;
    
    
    
  end;
end;

%%

figure(2);
clf
plot(outE-inE-diffsame(E)./dt/4,'g')
hold on
plot(-diffsame(E)./dt/4,'r')
plot(outE-inE)
legend('\epsilon','-dE/dt','\Delta uB')
title('Energy balance: 0 -- 45 cm');
