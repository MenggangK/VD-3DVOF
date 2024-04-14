function RMSE = RMSEcompute(u,v,w,ut,vt,wt)
%AAE 此处显示有关此函数的摘要
%   此处显示详细说明
border=3;

u=u(border:size(u,1)-border,border:size(u,2)-border,border:size(u,3)-border);
v=v(border:size(v,1)-border,border:size(v,2)-border,border:size(v,3)-border);
w=w(border:size(w,1)-border,border:size(w,2)-border,border:size(w,3)-border);

ut=ut(border:size(ut,1)-border,border:size(ut,2)-border,border:size(ut,3)-border);
vt=vt(border:size(vt,1)-border,border:size(vt,2)-border,border:size(vt,3)-border);
wt=wt(border:size(wt,1)-border,border:size(wt,2)-border,border:size(wt,3)-border);

sumerror=(u-ut).^2+(v-vt).^2+(w-wt).^2;
RMSE=sqrt(mean(sumerror(:)));
end

