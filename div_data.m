function div_d = div_data( pasi_derivativte )
   [x,y,z] = size(pasi_derivativte);
   div_d = zeros(x,y,z);
   pasi=pasi_derivativte;
   for i=1:x
       for j=1:y
           for k=1:z
               minX=max(i-1,1);
               maxX=min(i+1,x);
               minY=max(j-1,1);
               maxY=min(j+1,y);
               minZ=max(k-1,1);
               maxZ=min(k+1,z);
               div_d(i,j,k) = (pasi(maxX,j,k)+pasi(i,j,k))*0.5+(pasi(minX,j,k)+pasi(i,j,k))*0.5...
                             +(pasi(i,maxY,k)+pasi(i,j,k))*0.5+(pasi(i,minY,k)+pasi(i,j,k))*0.5...
                             +(pasi(i,j,maxZ)+pasi(i,j,k))*0.5+(pasi(i,j,minZ)+pasi(i,j,k))*0.5;
           end
       end
   end

end
