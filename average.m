function averageu = average(u)
   mask3D=zeros(3,3,3);
   mask3D(:,:,1)=[0,0,0;
                  0,1,0;
                  0,0,0];
   mask3D(:,:,2)=[0,1,0;
                  1,0,1;
                  0,1,0];
   mask3D(:,:,3)=[0,0,0;
                  0,1,0;
                  0,0,0];
   averageu = imfilter(u, mask3D,  'corr', 'symmetric', 'same');
end

