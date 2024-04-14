function u_bar = regularition_type(u)
%      u = medfilt3(u, [5 5 5], 'symmetric');
     eta=30;  
     ux = derivativte3DX(u);
     uy = derivativte3DY(u);
     uz = derivativte3DZ(u);
     pasi_derivativte = 1/(2*sqrt(ux.^2 + uy.^2 + uz.^2  + 0.001^2));
 
     div_d = div_data( pasi_derivativte );
   
     div_u = div_vector( pasi_derivativte, u);  
     u_bar=(u*eta+div_u)./(eta+div_d);    
end