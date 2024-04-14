function [ Ix, Iy, Iz,It ] = Warrping(I1, I2, u, v, w)

H   = size(I1, 1);
W   = size(I1, 2);
K   = size(I1, 3);

[x,y,z]   = meshgrid(1:W,1:H,1:K);
x2      = x - u;        
y2      = y - v;  
z2      = z - w; 
B1 = (x2>W) | (x2<1) | (y2>H) | (y2<1)| (z2>K) | (z2<1);
I1w  = interp3(x,y,z,I1,x2,y2,z2,'cubic',0);


DX =  [1,-8,0,8,-1]/12;
DY =  [1;-8;0;8;-1]/12;


DZ = zeros(1,1,5);
DZ(:,:,1) = 1;
DZ(:,:,2) = -8;
DZ(:,:,3) = 0;
DZ(:,:,4) = 8;
DZ(:,:,5) = -1;
DZ = DZ/12;

It=I2 - I1w;
I1xW = imfilter(I1w, DX,  'corr', 'symmetric', 'same');
I1yW = imfilter(I1w, DY,  'corr', 'symmetric', 'same');
I1zW = imfilter(I1w, DZ,  'corr', 'symmetric', 'same');

I2x = imfilter(I2, DX,  'corr', 'symmetric', 'same');
I2y = imfilter(I2, DY, 'corr', 'symmetric', 'same');
I2z = imfilter(I2, DZ, 'corr', 'symmetric', 'same');

Ix=0.5*I2x+0.5*I1xW;
Iy=0.5*I2y+0.5*I1yW;
Iz=0.5*I2z+0.5*I1zW;

Ix(B1) = 0;
Iy(B1) = 0;
Iz(B1) = 0;
It(B1) = 0;

end

