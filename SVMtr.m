function svm = SVMtr(X,Y,type,C)  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: 
% Build a model of svm.
% -----------------------------------
% Input:
% X:     Trian set
% Y:     The goal value of train set.
% type:  The type of kernel
% C:     the value of the parameter C
% -----------------------------------
% Output:
% svm:   The struct is model of svm.
% -----------------------------------
% Author:
% Diliao Xu

yy = unique(Y);
% 转换标签变为-1和1
Y(find(Y==yy(1))) = 1;
Y(find(Y==yy(2))) = -1;
  

% 最优化的过程，用优化函数quadprog求解
N = length(Y);  
H = (Y'*Y).*kernel(X,X,type);      
f = -ones(N,1); 
A = [];  
b = [];  
Aeq = Y; 
beq = 0;  
lb = zeros(N,1);  
ub = C*ones(N,1);  
a0 = zeros(N,1);  

% Options created using optimoptions or the Optimization app.
% Some options are absent from the optimoptions display. These options are listed in italics.
options = optimset;      
options.LargeScale = 'off';
options.Display = 'off';    
alpha = quadprog(H,f,A,b,Aeq,beq,lb,ub,a0,options);  


epsilon = 1e-8;    
% 找到相应的支持向量，并记录其标签
label = find(abs(alpha)>epsilon);
svm.alpha = alpha(label);  
svm.sv_x = X(:,label);  
svm.sv_y = Y(label);  
svm.svnum = length(label);  
end  