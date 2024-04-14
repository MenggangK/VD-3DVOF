function [SSIM] = apply_SSIM_compute(u1,u2, wSize,aerf)

% edge region: weighted median filtering, the weights are determined by
%  spatial distance, intensity distance, occlusion state
% smooth region: 

%   Author: Deqing Sun, Department of Computer Science, Brown University
%   Contact: dqsun@cs.brown.edu
%   $Date: 2009$
%   $Revision $
       
sz = size(u1);
u1(u1<0)=0;
u2(u2<0)=0;
u1=u1./max(u1(:))*255;
u2=u2./max(u2(:))*255;
bfhsz =ceil((wSize - 1)/2);

u0 = zeros(sz);

[indx_row, indx_col,indx_dep]=ndgrid(1:size(u1,1),1:size(u1,2),1:size(u1,3));
indx_row=indx_row(:);
indx_col=indx_col(:);
indx_dep=indx_dep(:);

pad_u1  = padarray(u1, bfhsz*[1 1 1], 'symmetric', 'both');              
pad_u2  = padarray(u2, bfhsz*[1 1 1], 'symmetric', 'both'); 

[H W D] = size(pad_u1);

Indx_Row = indx_row;
Indx_Col = indx_col;
Indx_Dep = indx_dep;

N        = length(Indx_Row); % number of elements to process
n        = 5e6;              % number of elements per batch
nB       = ceil(N/n);

for ib = 1:nB
    istart = (ib-1)*n + 1;
    iend   = min(ib*n, N);
    
    indx_row = Indx_Row(istart:iend);
    indx_col = Indx_Col(istart:iend);    
    indx_dep = Indx_Dep(istart:iend);
    
    [C R Z] = meshgrid(-bfhsz:bfhsz, -bfhsz:bfhsz, -bfhsz:bfhsz);
%     nindx = R + C*H;    
%     cindx = indx_row +bfhsz  + (indx_col+bfhsz-1)*H;
    nindx = R + C*H + Z*H*W;    
    cindx = indx_row +bfhsz  + (indx_col+bfhsz-1)*H  + (indx_dep+bfhsz-1)*H*W;
    
    pad_indx = repmat(nindx(:), [1 length(indx_row)]) + ...
               repmat(cindx(:)', [(bfhsz*2+1)^3, 1] ); 
    
    % Intensity weight
%     tmp_w = zeros(size(weights));    
    tmp1 = pad_u1(pad_indx);
    tmp2 = pad_u2(pad_indx);
    
    mu1=mean(tmp1);
    mu2=mean(tmp2);
%     c1=(0.01*255).^2; c2=(0.03*255).^2;
    sigma_1=sqrt((sum( (tmp1-repmat(mu1, [(bfhsz*2+1)^3, 1])).^2))./((bfhsz*2+1)^3-1));
    sigma_2=sqrt((sum( (tmp2-repmat(mu2, [(bfhsz*2+1)^3, 1])).^2))./((bfhsz*2+1)^3-1));
    sigma_12=(sum((tmp1-repmat(mu1, [(bfhsz*2+1)^3, 1])).*(tmp2-repmat(mu2, [(bfhsz*2+1)^3, 1]))))./((bfhsz*2+1)^3-1);
    c1=1; c2=1;
     p=(2*mu1.*mu2+c1).*(2*sigma_12+c2)./(mu1.^2+mu2.^2+c1)./(sigma_1.^2+sigma_2.^2+c2);

    indx = sub2ind(sz, indx_row, indx_col,indx_dep);
    u0(indx) = p;
    
    boder=3;
    u0(1:boder,:,:)=1;
    u0(:,1:boder,:)=1;
    u0(:,:,1:boder)=1;
    u0(size(u0,1)-boder:end,:,:)=1;
    u0(:,size(u0,2)-boder:end,:)=1;
    u0(:,:,size(u0,3)-boder:end)=1;
%     u0(u0<0)=0;
    SSIM=u0;
    
end