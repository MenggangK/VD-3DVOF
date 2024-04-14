function [u, v, w] = HS(u,v,w,Ix,Iy,Iz,It,lamda, Max_iter)
     
     u_last=u;
     v_last=v;
     w_last=w;

     Du = lamda.*Ix.*Ix + 6 ;
     Dv = lamda.*Iy.*Iy + 6 ;
     Dw = lamda.*Iz.*Iz + 6 ;
       
   for  iter=1:Max_iter
       averageu = average(u);
       averagev = average(v);
       averagew = average(w);

       Bu = - lamda.*Ix.*(It-Ix.*u_last-Iy.*v_last-Iz.*w_last)  + averageu  ;      
       Bv = - lamda.*Iy.*(It-Ix.*u_last-Iy.*v_last-Iz.*w_last)  + averagev  ;      
       Bw = - lamda.*Iz.*(It-Ix.*u_last-Iy.*v_last-Iz.*w_last)  + averagew  ;
      
       u1 =(Bu - lamda.*Ix.*Iy.*v  - lamda.*Ix.*Iz.*w)./Du;
       v1 =(Bv - lamda.*Ix.*Iy.*u1 - lamda.*Iy.*Iz.*w)./Dv;
       w1 =(Bw - lamda.*Ix.*Iz.*u1 - lamda.*Iy.*Iz.*v1)./Dw;
             
       total_error = sum(sum(sum((u-u1).^2 + (v-v1).^2 + (w-w1).^2)))/(size(Ix,1)*size(Ix,2)*size(Ix,3));
       fprintf('%d iteration error:%f \n',iter,total_error);
        u=u1;v=v1;w=w1;
       if total_error<10^(-10)
           break;
       end
   end    
 end
     


