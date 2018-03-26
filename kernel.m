function K = kernel(X1,X2,type)  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: 
% Select the kernel function.
% -----------------------------------
% Input:
% X&Y:   Data
% type:  The type of kernel
% -----------------------------------
% Output:
% K:     Inner-product.
% -----------------------------------
% Author:
% Diliao Xu

switch type  
case 'linear' 
    K = X1'*X2;  
case 'polynomial'
    K = (X1'*X2).*(X1'*X2).*(X1'*X2);
case 'rbf'    
    theta = 15;  
    theta = theta*theta;  
    XX = sum(X1'.*X1',2);
    YY = sum(X2'.*X2',2);  
    XY = X1'*X2;  
    K = abs(repmat(XX,[1 size(YY,1)]) + repmat(YY',[size(XX,1) 1]) - 2*XY);  
    K = exp(-K./theta);  
end  
end 
