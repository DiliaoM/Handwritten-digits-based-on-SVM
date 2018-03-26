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
% ��ֵ
b = mean(svm.sv_y-mu);  
W = (svm.alpha'.*svm.sv_y)*kernel(svm.sv_x,X,type);  
% ��Ǻ����������
Y = sign(W+b); 

% ����������Ŀ�����±���
Y(find(Y>0)) = i-1;
Y(find(Y<0)) = j-1;

% ת�ó�һ��
Y = Y';

end  

