function Y = SVMte(svm, X,type,i,j)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: 
% Predict the value of the test set with models learning by training set. 
% -----------------------------------
% Input:
% svm:   The struct is model of svm.
% X:     Test set
% type:  The type of kernel.
% i&j:   The labels of this prediction
% -----------------------------------
% Output:
% Y:     Prediction results
% -----------------------------------
% Author:
% Diliao Xu


mu = (svm.alpha'.*svm.sv_y)*kernel(svm.sv_x,svm.sv_x,type);  
% 阈值
b = mean(svm.sv_y-mu);  
W = (svm.alpha'.*svm.sv_y)*kernel(svm.sv_x,X,type);  
% 标记函数（结果）
Y = sign(W+b); 

% 输出结果，将目标重新编码
Y(find(Y>0)) = i-1;
Y(find(Y<0)) = j-1;

% 转置成一列
Y = Y';

end  

