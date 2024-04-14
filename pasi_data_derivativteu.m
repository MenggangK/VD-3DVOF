function pasi_derivativte = pasi_data_derivativteu(u)

ux = derivativte3DX(u);
uy = derivativte3DY(u);
uz = derivativte3DZ(u);
pasi_derivativte = 1/(2*sqrt(ux.^2 + uy.^2 + uz.^2  + 0.001^2));

end

 