function  ux = derivativte3DX(u)
%x为size(image,2)的方向  y为size(image,1)的方向  z为size(image,3)的方向
D3 = [-1;0;1]/2;
h=D3; 
ux = imfilter(u, h',  'corr', 'symmetric', 'same');
end

