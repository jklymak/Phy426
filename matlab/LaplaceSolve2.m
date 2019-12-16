% Solve Laplace's eqn.  

nz = 200;
nx = 200;

psi = zeros(nz,nx);

psi(:,1) = (0:(nz-1))/(nz-1);
psi = repmat(psi(:,1),1,nx);

inz=2:nz-1
inx = 2:nx-1;

R = 10;
x = 1:nx;x=x-mean(x);
z = (1:nz)/4;z=z-mean(z);
z = z;
[X,Z]=meshgrid(x,z);
for i=1:length(x);
  if length(in)>0
    top(i)=max(in);
    bot(i)=min(in);
  else
    top(i)=NaN;
    bot(i)=NaN;
  end
  
end

x1=-0
z1=-0
R=10;
inBod = find((X-x1).^2+(Z-z1).^2<R.^2);
num = 0;
for ii=1:nx;
  for jj = 1:nz;
    if (x(ii)-x1).^2+(z(jj)-z1).^2<R.^2
      num=num+1;
      indi(num,5)=ii;
      indj(num,5)=jj;
      if (x(ii+1)-x1).^2+(z(jj)-z1).^2>R.^2
        indi(num,1)=ii+1;
        indj(num,1)=jj;
      else
        indi(num,1)=NaN;
        indj(num,1)=NaN;
      end
      if (x(ii-1)-x1).^2+(z(jj)-z1).^2>R.^2
        indi(num,2)=ii-1;
        indj(num,2)=jj;
      else
        indi(num,2)=NaN;
        indj(num,2)=NaN;
      end
      if (x(ii)-x1).^2+(z(jj+1)-z1).^2>R.^2
        indi(num,3)=ii;
        indj(num,3)=jj+1;
      else
        indi(num,3)=NaN;
        indj(num,3)=NaN;
      end
      if (x(ii)-x1).^2+(z(jj-1)-z1).^2>R.^2
        indi(num,4)=ii;
        indj(num,4)=jj+1;
      else
        indi(num,4)=NaN;
        indj(num,4)=NaN;
      end
      
    end
  end  
end;

frontx = max(find((x-x1)<-R));
frontz = min(find((z-z1)>=0));



R2 = 5;

x2=12;
z2=12;

inBod2 = find((X-x2).^2+(Z-z2).^2<R2.^2);
front2x = max(find((x-x2)<-R2));
front2z = min(find((z-z2)>=0));
er=NaN*zeros(1,100000);



for i=1:50000;
  % upstream, downstream
  psi0=psi;
  psi(:,1) = (0:(nz-1))/(nz-1);
  psi(:,end) = (0:(nz-1))/(nz-1);
  
  
  % top and bottom
  
  
  psi(1,:)=0;psi(end,:)=1;
  psi(inBod)=psi(frontz,frontx);
  
  for jj=1:length(indi);
    nn=0
    psi(indj(jj,5),indi(jj,5))=0;
    for ii=1:4
      if ~isnan(indi(jj,ii)+indj(jj,ii))
        psi(indj(jj,5),indi(jj,5))=psi(indj(jj,ii),indi(jj,ii))+ psi(indj(jj,5),indi(jj,5));
      end
    end
    if nn>0
      psi(indj(jj,5),indi(jj,5))=psi(indj(jj,5),indi(jj,5))/nn;
    else
      psi(indj(jj,5),indi(jj,5))=0;
    end
  end;
  
  
  
  P1=psi(frontz,frontx);
  psi(inBod2)=psi(front2z,front2x);
  P2=psi(front2z,front2x);
  
  psi(inz,inx)=(psi(inz,inx+1)+psi(inz,inx-1)+psi(inz+1,inx)+psi(inz-1,inx))/4;
  
  % Make the leading edge of object all same streamline...
  
  if mod(i,1000000)==0;
    clf
    contour(psi,25);
    drawnow;
    
  end;
  
  er(i)=sum((psi0(:)-psi(:)).^2);
  if er(i)<1e-9
    break;
  end;
  
end;
clf
contour(x,z,psi,25*2);
hold on;
contour(x,z,psi,[P1 P1+0.001]);
contour(x,z,psi,[P2 P2+0.001]);
axis equal;


