function  ux = derivativte3DX(u)
%xΪsize(image,2)�ķ���  yΪsize(image,1)�ķ���  zΪsize(image,3)�ķ���
D3 = [-1;0;1]/2;
h=D3; 
ux = imfilter(u, h',  'corr', 'symmetric', 'same');
end

