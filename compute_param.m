function [param]=compute_param(I1,I2,Ix,Iy,Iz,It,u0,v0,w0, wSize,sigma_r,sigma_i)    
     H   = size(I1, 1);
     W   = size(I1, 2);
     K   = size(I1, 3);

    [x,y,z]   = meshgrid(1:W,1:H,1:K);
    x2      = x - u0;        
    y2      = y - v0;  
    z2      = z - w0; 
    I1w  = interp3(x,y,z,I1,x2,y2,z2,'cubic',0);
    aerf=3;
     [SSIM] = apply_SSIM_compute(I1w,I2, 3,aerf);
    r0=It-Ix.*u0-Iy.*v0-Iz.*w0;
   
     [param.IIxIx,param.IIyIy,param.IIzIz,...
      param.IIxr0,param.IIyr0,param.IIzr0,...
      param.IIxIy,param.IIyIz,param.IIxIz] = applyBilateralFilter108(Ix.*Ix, Iy.*Iy, Iz.*Iz,...
                                                                        Ix.*r0, Iy.*r0, Iz.*r0,...
                                                                        Ix.*Iy, Iy.*Iz, Ix.*Iz, I2,SSIM, wSize, sigma_r, sigma_i);  

      
     param.pasi_derivativteu = pasi_data_derivativteu(u0);
     param.pasi_derivativtev = pasi_data_derivativteu(v0);
     param.pasi_derivativtew = pasi_data_derivativteu(w0);
     
     param.div_du = div_data(param.pasi_derivativteu );
     param.div_dv = div_data(param.pasi_derivativtev );
     param.div_dw = div_data(param.pasi_derivativtew );
end