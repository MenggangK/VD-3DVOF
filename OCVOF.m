function [u, v, w] = OCVOF(param,u,v,w,lamda, Maxin_iter,Maxout_iter,ksan_xx,ksan_yy,ksan_zz,ksan_xy,ksan_xz,ksan_yz,omiga_x,omiga_y,omiga_z)
      
     u = medfilt3(u, [5 5 5], 'symmetric');  
     v = medfilt3(v, [5 5 5], 'symmetric');
     w = medfilt3(w, [5 5 5], 'symmetric'); 
     
     detaX_ksan_xx = derivativte3DX(ksan_xx);
     detaY_ksan_xy = derivativte3DY(ksan_xy);
     detaY_omiga_z = derivativte3DY(omiga_z);
     detaZ_ksan_xz = derivativte3DZ(ksan_xz);
     detaZ_omiga_y = derivativte3DZ(omiga_y);
          
     detaX_ksan_xy = derivativte3DX(ksan_xy);
     detaX_omiga_z = derivativte3DX(omiga_z);
     detaY_ksan_yy = derivativte3DY(ksan_yy);
     detaZ_ksan_yz = derivativte3DZ(ksan_yz);
     detaZ_omiga_x = derivativte3DZ(omiga_x);   
     
     detaX_ksan_xz = derivativte3DX(ksan_xz);
     detaX_omiga_y = derivativte3DX(omiga_y);
     detaY_ksan_yz = derivativte3DY(ksan_yz);
     detaY_omiga_x = derivativte3DY(omiga_x);
     detaZ_ksan_zz = derivativte3DZ(ksan_zz);
     
     IIxIx=param.IIxIx;
     IIyIy=param.IIyIy;
     IIzIz=param.IIzIz;
     
     IIxr0=param.IIxr0;
     IIyr0=param.IIyr0;
     IIzr0=param.IIzr0;
     
     IIxIy=param.IIxIy;
     IIyIz=param.IIyIz;
     IIxIz=param.IIxIz; 
     
     pasi_derivativteu=param.pasi_derivativteu;
     pasi_derivativtev=param.pasi_derivativtev;
     pasi_derivativtew=param.pasi_derivativtew;

     div_du=param.div_du;
     div_dv=param.div_dv;
     div_dw=param.div_dw;
     
     eta=30;
     Du = lamda.*IIxIx +  div_du + 6*eta;
     Dv = lamda.*IIyIy +  div_dv + 6*eta;
     Dw = lamda.*IIzIz +  div_dw + 6*eta;
 
  for in_iter=1:Maxin_iter
       u_bar=average(u);
       v_bar=average(v);
       w_bar=average(w); 
       
       div_u = div_vector( pasi_derivativteu, u);
       div_v = div_vector( pasi_derivativtev, v);
       div_w = div_vector( pasi_derivativtew, w);

       Bu = - lamda .*IIxr0  +  div_u + u_bar*eta +(- detaX_ksan_xx - detaY_ksan_xy + detaY_omiga_z - detaZ_ksan_xz - detaZ_omiga_y )*eta;      
       Bv = - lamda .*IIyr0  +  div_v + v_bar*eta +(- detaX_ksan_xy - detaX_omiga_z - detaY_ksan_yy - detaZ_ksan_yz + detaZ_omiga_x )*eta;      
       Bw = - lamda .*IIzr0  +  div_w + w_bar*eta +(- detaX_ksan_xz + detaX_omiga_y - detaY_ksan_yz - detaY_omiga_x - detaZ_ksan_zz )*eta;

       u1 = (Bu - lamda.*IIxIy.*v- lamda.*IIxIz.*w)./Du;
       v1 = (Bv - lamda.*IIxIy.*u1 - lamda.*IIyIz.*w)./Dv;
       w1 = (Bw - lamda.*IIxIz.*u1 - lamda.*IIyIz.*v1)./Dw;
       
       total_error_in = sum(sum(sum((u-u1).^2 + (v-v1).^2 + (w-w1).^2)))/(size(u,1)*size(u,2)*size(u,3));
       
       u=u1;v=v1;w=w1;
       
       if total_error_in<10^(-10)
           break;
       end      
  end 
       fprintf(' error:%f\n',total_error_in);
end