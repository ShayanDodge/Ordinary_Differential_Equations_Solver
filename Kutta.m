format compact
syms x y
f=input('f(x,y)=')
n=input('n=')
x_0=input('x_0=')
x_n=input('x_n=')
h=(x_n-x_0)/n;
X=zeros(1,n+1);
Y=zeros(1,n+1);
Y(1)=input('y_0=')
X=[x_0:h:x_n];
for i=1:n
    k_1=subs(f,[x,y],[X(i),Y(i)]);
    k_2=subs(f,[x,y],[X(i)+h,Y(i)+k_1*h]);
    Y(i+1)=Y(i)+(k_1+k_2)*(h/2);
end
T=[X;Y]
plot(X,Y)
syms x
y=input('exact y(x)=')
Y(i)=subs(y,X(i));
plot(X,Y,'r')