function  uz= derivativte3DZ(u)
%x为size(image,2)的方向  y为size(image,1)的方向  z为size(image,3)的方向

D2=zeros(1,1,3);
D2(:,:,1)=-0.5;
D2(:,:,2)= 0;
D2(:,:,3)= 0.5;

ht=D2;
uz = imfilter(u, ht, 'corr', 'symmetric', 'same');
end

