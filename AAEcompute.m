function AAE = AAEcompute(u,v,w,ut,vt,wt)
%AAE 此处显示有关此函数的摘要
%   此处显示详细说明

border=3;
border2=3;
u=u(border2:size(u,1)-border2,border2:size(u,2)-border2,border:size(u,3)-border);
v=v(border2:size(v,1)-border2,border2:size(v,2)-border2,border:size(v,3)-border);
w=w(border2:size(w,1)-border2,border2:size(w,2)-border2,border:size(w,3)-border);

ut=ut(border2:size(ut,1)-border2,border2:size(ut,2)-border2,border:size(ut,3)-border);
vt=vt(border2:size(vt,1)-border2,border2:size(vt,2)-border2,border:size(vt,3)-border);
wt=wt(border2:size(wt,1)-border2,border2:size(wt,2)-border2,border:size(wt,3)-border);

u=u(:);
v=v(:);
w=w(:);
ut=ut(:);
vt=vt(:);
wt=wt(:);
fenzi=u.*ut+v.*vt+w.*wt;
fenmu=(sqrt(u.^2+v.^2+w.^2)).* (sqrt(ut.^2+vt.^2+wt.^2));
fen=fenzi./fenmu;
fen(fen>1)=1;
AAEmatrix = acosd(fen);
AAE= mean(AAEmatrix(:));
end

