function [u,v,w,ksan_xx,ksan_yy,ksan_zz,ksan_xy,ksan_xz,ksan_yz,omiga_x,omiga_y,omiga_z]= ...
          VDOCVOF(I1,I2,u,v,w, Ix, Iy, Iz, It ,lamda2, Maxin_iter, Maxout_iter, total_iter,  ...
                  ksan_xx,ksan_yy,ksan_zz,ksan_xy,ksan_xz,ksan_yz,omiga_x,omiga_y,omiga_z)

u0=u;v0=v;w0=w;   
wSize=5;sigma_r=12/6; sigma_i=3;
param=compute_param(I1,I2,Ix,Iy,Iz,It,u0,v0,w0, wSize,sigma_r,sigma_i);
%%
for iter=1:total_iter
    
  if iter==10  
      Maxin_iter=500;
  end
 [u1, v1, w1] = OCVOF(param,u,v,w ,lamda2, Maxin_iter,Maxout_iter,ksan_xx,ksan_yy,ksan_zz,ksan_xy,ksan_xz,ksan_yz,omiga_x,omiga_y,omiga_z);
%%
[ksan_xx,ksan_yy,ksan_zz,ksan_xy,ksan_xz,ksan_yz,omiga_x,omiga_y,omiga_z]= physics(u1,v1,w1);
%%
 error = sum(sum(sum((u-u1).^2 + (v-v1).^2 + (w-w1).^2)))/(size(Ix,1)*size(Ix,2)*size(Ix,3));
 if error<10^(-10)
      break;
 end              
 fprintf('%d iteration detaUVW :error:%f\n',iter,error);
 u=u1; v=v1; w=w1;
end
 u = medfilt3(u1, [5 5 5], 'symmetric');  
 v = medfilt3(v1, [5 5 5], 'symmetric');
 w = medfilt3(w1, [5 5 5], 'symmetric');
end