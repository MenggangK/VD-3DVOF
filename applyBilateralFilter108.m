function  [u0,v0,w0,u10,v10,w10,u20,v20,w20]=applyBilateralFilter108(u,v,w,u1,v1,w1,u2,v2,w2,im,SSIM,wSize,sigma_d,aerfI)
   sz = size(im);
   u0 = zeros(sz);
   v0 = zeros(sz);
   w0 = zeros(sz);

   u10 = zeros(sz);
   v10 = zeros(sz);
   w10 = zeros(sz);

   u20 = zeros(sz);
   v20 = zeros(sz);
   w20 = zeros(sz);
   
    squared_sigma_d =  sigma_d * sigma_d;   
    wr =ceil((wSize - 1)/2);
    
    [height,width,deep]=size(im);
    
    for i=1:height 
      for j=1:width
        for k=1:deep
              sumu0=0;
              sumv0=0;
              sumw0=0;
              
              sumu10 = 0;
              sumv10 = 0;
              sumw10 = 0;

              sumu20 = 0;
              sumv20 = 0;
              sumw20 = 0; 
              
              sumWeights = 0;
           
             for x= -wr: wr                             
               for y= -wr: wr                  
                 for z= -wr: wr              
                    
                    indX = i + x;
                    indY = j + y;
                    indZ = k + z;
                    indX=max(indX,1);
                    indX=min(indX,height);
                    indY=max(indY,1);   
                    indY=min(indY,width);
                    indZ=max(indZ,1);
                    indZ=min(indZ,deep);

                    exponent_d= (0- (i - indX) * (i - indX)- (j - indY) * (j - indY)-(k - indZ) * (k - indZ));
			        exponent_d=exponent_d/(2*squared_sigma_d);
                    distanceFactor = exp(exponent_d);
                    
			        norm1=exp(aerfI*im(indX,indY,indZ));
                  norm2=exp(aerfI*SSIM(indX,indY,indZ)); 		                                        
                   combinedFactor = distanceFactor *norm1*norm2;  
%                    combinedFactor = distanceFactor; 
				   sumWeights = sumWeights + combinedFactor;
                   
                   sumu0=sumu0+ combinedFactor * u(indX,indY,indZ);
                   sumv0=sumv0+ combinedFactor * v(indX,indY,indZ);
                   sumw0=sumw0+ combinedFactor * w(indX,indY,indZ);
              
                   sumu10 = sumu10+ combinedFactor * u1(indX,indY,indZ);
                   sumv10 = sumv10+ combinedFactor * v1(indX,indY,indZ);
                   sumw10 = sumw10+ combinedFactor * w1(indX,indY,indZ);

                   sumu20 = sumu20+ combinedFactor * u2(indX,indY,indZ);
                   sumv20 = sumv20+ combinedFactor * v2(indX,indY,indZ);
                   sumw20 = sumw20+ combinedFactor * w2(indX,indY,indZ); 
                 end
               end
             end
                      
           u0(i,j,k)= sumu0/sumWeights;
           v0(i,j,k)= sumv0/sumWeights;
           w0(i,j,k)= sumw0/sumWeights;
           
           u10(i,j,k)= sumu10/sumWeights;
           v10(i,j,k)= sumv10/sumWeights;
           w10(i,j,k)= sumw10/sumWeights;
           
           u20(i,j,k)= sumu20/sumWeights;
           v20(i,j,k)= sumv20/sumWeights;
           w20(i,j,k)= sumw20/sumWeights;
        end
      end
    end
end
