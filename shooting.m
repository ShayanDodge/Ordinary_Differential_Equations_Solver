format compact
syms x;
m=2;
u =sym('u', [1;m]);
u=reshape(u,[m,1]);
n=input('n=');
x_0=input('x_0=');
x_n=input('x_n=');
p=input('p(x)=');q=input('q(x)=');r=input('r(x)=');B=input('u(n)=');
for I=1:2
h=(x_n-x_0)/n;
k=zeros(4,m);
U=zeros(m,n+1);
X=[x_0:h:x_n];
X=reshape(X,[n+1,1]);
if I==1
f(m)=p.*u(2)+q.*u(1)+r;
U(1,1)=input('u(0)=');
U(2,1)=0; 
else
f(m)=p.*u(2)+q.*u(1); 
U(1,1)=0;
U(2,1)=1; 
end
for i=1:m-1
f(i)=u(i+1);
end
for j=1:n 
for i=1:m
U1=[U(1:m,j)];
k(1,i)=subs(f(i),[x;u],[X(j);U1]);
end
for i=1:m
k1=reshape(k(1,1:m),[m,1]);
U2=[U(1:m,j)+(k1.*(h./2))];
k(2,i)=subs(f(i),[x;u],[X(j)+(h./2);U2]);
end
for i=1:m 
k2=reshape(k(2,1:m),[m,1]);
U3=[U(1:m,j)+(k2.*(h./2))];
k(3,i)=subs(f(i),[x;u],[X(j)+(h./2);U2]);
end
for i=1:m
k3=reshape(k(3,1:m),[m,1]);    
U4=[U(1:m,j)+k3.*h];
k(4,i)=subs(f(i),[x;u],[X(j)+h;U4]);
end
for i=1:m
U(i,j+1)=U(i,j)+(k(1,i)+2.*k(2,i)+2.*k(3,i)+k(4,i)).*(h./6);
end
end
if I==1
U_1=U(1,:);b=U(1,n+1);
else
U=U_1+((B-b)./(U(1,n+1))).*U(1,:)
end
end
c_2=(8-(12.*sin(log(2)))-(4.*cos(log(2))))./70;
c_1=1.1-c_2;
Y=c_1.*X+c_2./(X.^2)-(0.3).*sin(log(X))-(0.1).*cos(log(X));
hold on
plot(X,Y)
plot(X,U,'.-')