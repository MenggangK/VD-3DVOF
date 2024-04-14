function [u, pu] = regularition_type1( u_, pu )
 tau=0.5;
% D=ones(size(u_));

 div_u =  derivativte3DX(pu(:, :, :,1)) + derivativte3DY(pu(:, :, :,2)) + derivativte3DZ(pu(:, :, :,3)) ;
 u = u_ + 0.5*div_u;
 
 ux = derivativte3DX(u);
 uy = derivativte3DY(u);
 uz = derivativte3DZ(u);
 

%  u0=u;
%  ux0 = derivativte3DX(u0);
%  uy0 = derivativte3DY(u0);
%  uz0 = derivativte3DZ(u0);
 
%  pu(:, :, :, 1) = pu(:, :, :, 1) + tau * ux0;
%  pu(:, :, :, 2) = pu(:, :, :, 2) + tau * uy0;
%  pu(:, :, :, 3) = pu(:, :, :, 3) + tau * uz0;

 pu(:, :, :, 1) = (pu(:, :, :, 1) + tau * ux)./(1+tau *sqrt(ux.^2 + uy.^2 + uz.^2 ));
 pu(:, :, :, 2) = (pu(:, :, :, 2) + tau * uy)./(1+tau *sqrt(ux.^2 + uy.^2 + uz.^2 ));
 pu(:, :, :, 3) = (pu(:, :, :, 3) + tau * uz)./(1+tau *sqrt(ux.^2 + uy.^2 + uz.^2 ));
  
%  pu(:, :, :, 1) = (pu(:, :, :, 1) + tau * ux0)./(1+tau *sqrt(ux0.^2 + uy0.^2 + uz0.^2 ));
%  pu(:, :, :, 2) = (pu(:, :, :, 2) + tau * uy0)./(1+tau *sqrt(ux0.^2 + uy0.^2 + uz0.^2 ));
%  pu(:, :, :, 3) = (pu(:, :, :, 3) + tau * uz0)./(1+tau *sqrt(ux0.^2 + uy0.^2 + uz0.^2 ));
 
%  pu(:, :, :, 1) = (pu(:, :, :, 1) + tau * ux)./max(abs(pu(:, :, :, 1) + tau * ux0), D) .* D;
%  pu(:, :, :, 2) = (pu(:, :, :, 2) + tau * uy)./max(abs(pu(:, :, :, 2) + tau * uy0), D) .* D;
%  pu(:, :, :, 3) = (pu(:, :, :, 3) + tau * uz)./max(abs(pu(:, :, :, 3) + tau * uz0), D) .* D;
end


