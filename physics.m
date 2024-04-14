function [ksan_xx,ksan_yy,ksan_zz,ksan_xy,ksan_xz,ksan_yz,omiga_x,omiga_y,omiga_z]= physics(u1,v1,w1)


u3 = medfilt3(u1, [5 5 5], 'symmetric');
v3 = medfilt3(v1, [5 5 5], 'symmetric');
w3 = medfilt3(w1, [5 5 5], 'symmetric');
ksan_xx = derivativte3DX(u3);
ksan_yy = derivativte3DY(v3);
ksan_zz = derivativte3DZ(w3);

ksan_xy = (derivativte3DY(u3) + derivativte3DX(v3))*0.5;
ksan_xz = (derivativte3DZ(u3) + derivativte3DX(w3))*0.5;
ksan_yz = (derivativte3DZ(v3) + derivativte3DY(w3))*0.5;

omiga_x = (derivativte3DY(w3) - derivativte3DZ(v3))*0.5;
omiga_y = (derivativte3DZ(u3) - derivativte3DX(w3))*0.5;
omiga_z = (derivativte3DX(v3) - derivativte3DY(u3))*0.5;
 
[ksan_xx] = regularition_type( ksan_xx);
[ksan_yy] = regularition_type( ksan_yy);
[ksan_zz] = regularition_type( ksan_zz);

[ksan_xy] = regularition_type( ksan_xy );
[ksan_xz] = regularition_type( ksan_xz );
[ksan_yz] = regularition_type( ksan_yz );

[omiga_x] = regularition_type( omiga_x );
[omiga_y] = regularition_type( omiga_y );
[omiga_z] = regularition_type( omiga_z );

% [ksan_xx] = regularition_type1( ksan_xx,pksan_xx);
% [ksan_yy] = regularition_type1( ksan_yy,pksan_yy);
% [ksan_zz] = regularition_type1( ksan_zz,pksan_zz);
% 
% [ksan_xy] = regularition_type1( ksan_xy,pksan_xy );
% [ksan_xz] = regularition_type1( ksan_xz,pksan_xz );
% [ksan_yz] = regularition_type1( ksan_yz,pksan_yz );
% 
% [omiga_x] = regularition_type1( omiga_x,pomiga_x );
% [omiga_y] = regularition_type1( omiga_y,pomiga_y );
% [omiga_z] = regularition_type1( omiga_z,pomiga_z );
end