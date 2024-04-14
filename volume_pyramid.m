function P = volume_pyramid(img, nL)

P   = cell(nL,1);
tmp = img;
P{1}= tmp;

for m = 2:nL
    f = fspecial3('gaussian', 5, 1);
%     f = fspecial3('gaussian', 5, 5/6);
    tmp = imfilter(tmp, f, 'corr', 'symmetric', 'same');           
    tmp = imresize3(tmp, 0.5, 'cubic', 'Antialiasing', false); 
%     tmp = imresize3(tmp, 0.5, 'bilinear');  
    P{m} = tmp;
end

	


	
	


