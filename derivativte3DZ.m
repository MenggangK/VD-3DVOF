function  uz= derivativte3DZ(u)
%xΪsize(image,2)�ķ���  yΪsize(image,1)�ķ���  zΪsize(image,3)�ķ���

D2=zeros(1,1,3);
D2(:,:,1)=-0.5;
D2(:,:,2)= 0;
D2(:,:,3)= 0.5;

ht=D2;
uz = imfilter(u, ht, 'corr', 'symmetric', 'same');
end

