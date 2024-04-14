clear all;clc;
tic
load('recon_A.mat','recon_A');load('recon_B.mat','recon_B');
  
% recon_A=recon_A(71:530,71:530,11:110);
% recon_B=recon_B(71:530,71:530,11:110);
recon_A=recon_A(71:170,71:170,11:110);
recon_B=recon_B(71:170,71:170,11:110);
%%
Max_iter=500;

lambda1=400;   
lamda2=4000;
  
total_iter=10;
Maxin_iter=200; Maxout_iter=2;  

settings.PYRE_NO = 3;
settings.ITER_NO = 5;  
settings.method = 'VDVOF';
% settings.method = 'HS';
%%
Apyre=volume_pyramid(recon_A,settings.PYRE_NO);
Bpyre=volume_pyramid(recon_B,settings.PYRE_NO);
 
for p = settings.PYRE_NO:-1:1     
       fprintf('Pyramid level: %d\n',p)
       I1 = Apyre{p};
       I2 = Bpyre{p};
       I1=I1./max(I1(:));I2=I2./max(I2(:));
       
       if p == settings.PYRE_NO
          u = zeros(size( Apyre{p} ));  
          v = zeros(size( Apyre{p} ));
          w = zeros(size( Apyre{p} ));
          switch (settings.method)
             case  'VDVOF' 
              ksan_xx = zeros(size( Apyre{p} ));
              ksan_yy = zeros(size( Apyre{p} ));
              ksan_zz = zeros(size( Apyre{p} ));

              ksan_xy = zeros(size( Apyre{p} ));
              ksan_xz = zeros(size( Apyre{p} ));
              ksan_yz = zeros(size( Apyre{p} )); 

              omiga_x = zeros(size( Apyre{p} ));
              omiga_y = zeros(size( Apyre{p} ));
              omiga_z = zeros(size( Apyre{p} ));
          end 
       end    
       
       for k = 1:settings.ITER_NO 
          fprintf('warping: %d\n',k)                  
          [ Ix, Iy, Iz,It ] = Warrping(I1, I2, u, v, w);
        if  k>=2 && p==1 
            [u,v,w,ksan_xx,ksan_yy,ksan_zz,ksan_xy,ksan_xz,ksan_yz,omiga_x,omiga_y,omiga_z]= ...
             VDOCVOF(I1,I2,u,v,w, Ix, Iy, Iz, It ,lamda2, Maxin_iter, Maxout_iter, total_iter,  ...
             ksan_xx,ksan_yy,ksan_zz,ksan_xy,ksan_xz,ksan_yz,omiga_x,omiga_y,omiga_z);
              
        else
            [u, v, w] = HS(u,v,w,Ix,Iy,Iz,It,lambda1, Max_iter);
             u = medfilt3(u, [5 5 5], 'symmetric');
             v = medfilt3(v, [5 5 5], 'symmetric');
             w = medfilt3(w, [5 5 5], 'symmetric');            
        end         
       end            
     
          if p ~= 1   %扩展u，v，w的大小

             u =  size(Apyre{p-1},1)/size(Apyre{p},1)*imresize3(u,size(Apyre{p-1}),'cubic');%linear
             v =  size(Apyre{p-1},1)/size(Apyre{p},1)*imresize3(v,size(Apyre{p-1}),'cubic');
             w =  size(Apyre{p-1},1)/size(Apyre{p},1)*imresize3(w,size(Apyre{p-1}),'cubic');
             
             switch (settings.method)
               case  'VDVOF' 
                ksan_xx =  size(Apyre{p-1},1)/size(Apyre{p},1)*imresize3(ksan_xx,size(Apyre{p-1}),'cubic');%linear
                ksan_yy =  size(Apyre{p-1},1)/size(Apyre{p},1)*imresize3(ksan_yy,size(Apyre{p-1}),'cubic');
                ksan_zz =  size(Apyre{p-1},1)/size(Apyre{p},1)*imresize3(ksan_zz,size(Apyre{p-1}),'cubic');
             
                ksan_xy =  size(Apyre{p-1},1)/size(Apyre{p},1)*imresize3(ksan_xy,size(Apyre{p-1}),'cubic');%linear
                ksan_xz =  size(Apyre{p-1},1)/size(Apyre{p},1)*imresize3(ksan_xz,size(Apyre{p-1}),'cubic');
                ksan_yz =  size(Apyre{p-1},1)/size(Apyre{p},1)*imresize3(ksan_yz,size(Apyre{p-1}),'cubic');
             
                omiga_x =  size(Apyre{p-1},1)/size(Apyre{p},1)*imresize3(omiga_x,size(Apyre{p-1}),'cubic');%linear
                omiga_y =  size(Apyre{p-1},1)/size(Apyre{p},1)*imresize3(omiga_y,size(Apyre{p-1}),'cubic');
                omiga_z =  size(Apyre{p-1},1)/size(Apyre{p},1)*imresize3(omiga_z,size(Apyre{p-1}),'cubic');
             end
          end 
end
u = medfilt3(u, [5 5 5], 'symmetric');
v = medfilt3(v, [5 5 5], 'symmetric');
w = medfilt3(w, [5 5 5], 'symmetric');     