jmkfigure(1,2,0.7);clf
nn=0;
for Q = [1 2];
  nn = nn+1;
  g = 9.8;

  hm = (Q^2/g)^(1/3);

  um = sqrt(hm*g);

  x = [-100:100];
  bm=1;
  b = bm*exp(-x.^2/(25)^2);


  dx =1;
  dbdx = diffsame(b)./diffsame(x);

  x = x*dx;
  m = ceil(length(x)/2)
  h(m)=hm;
  clear h;
  h = ones(3,1)*x*0;

  for i=1:length(x)
    c(4) = 0.5*Q^2;
    c(1) = g;
    c(2) = -((3/2)*g*(Q^2/g)^(1/3)+g*(bm-b(i)));
    c(3)=0;
    h(:,i) = roots(c);
  end;

  figure(1);

  subplot3(3,1,1);
  plot(x,h(1,:)+b,'k--');
  hold on;
  plot(x,h(2,:)+b,'k--');
  plot(x,b,'k','linewi',2);
  plot(x(1:end/2),b(1:end/2)+h(1,1:end/2),'k');
  plot(x((end/2):end),b(end/2:end)+h(2,(end/2):end),'k');
  set(gca,'ylim',[0 2.5]);
  ylabel('z');
  
  
  subplot3(3,1,2);
  plot(x,Q./h(1,:),'k--');
  hold on;
  plot(x,Q./h(2,:),'k--');
  plot(x(1:end/2),Q./h(1,1:end/2),'k');
  plot(x((end/2):end),Q./h(2,(end/2):end),'k');
  F2 = Q./h(2,:)./sqrt(h(2,:)*g);
  F1 = Q./h(1,:)./sqrt(h(2,:)*g);
  set(gca,'ylim',[0 6.5])
  
  ylabel('u');
  subplot3(3,1,3);
  plot(x,F1,'k--');
  hold on;
  plot(x,F2,'k--');
  plot(x(end/2:end),F2(end/2:end),'k');
  plot(x(1:end/2),F1(1:end/2),'k');
  set(gca,'ylim',[0 5]);
  plot(x,0*x+1);
  xlabel('x');
  ylabel('u/(gh)^{1/2}');
  
  if dop
    docprint(sprintf('Hydr%d',nn),'Control.m');
  end;
  
end;

