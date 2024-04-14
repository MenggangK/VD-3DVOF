function I = imageweight(I1, I2, u, v, w)
%x为size(image,2)的方向  y为size(image,1)的方向  z为size(image,3)的方向

H   = size(I1, 1);
W   = size(I1, 2);
K   = size(I1, 3);

[x,y,z]   = meshgrid(1:W,1:H,1:K);
x2      = x + 0.5*u;        
y2      = y + 0.5*v;  
z2      = z + 0.5*w; 
B1 = (x2>W) | (x2<1) | (y2>H) | (y2<1)| (z2>K) | (z2<1);
I2W  = interp3(x,y,z,I2,x2,y2,z2,'cubic',0);

x3      = x - 0.5*u;        
y3      = y - 0.5*v;  
z3      = z - 0.5*w; 
B2 = (x3>W) | (x3<1) | (y3>H) | (y3<1)| (z3>K) | (z3<1);
I1W  = interp3(x,y,z,I1,x3,y3,z3,'cubic',0);

I=0.5*I2W+0.5*I1W;
I(B1) = 0;
I(B2) = 0;

end

