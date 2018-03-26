function [w,b,t] = LDAtr(X,Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: 
% Build a model with LDA. 
% -----------------------------------------------------------
% Model:
% y = x*w +w_0
% -----------------------------------------------------------
% Input:
% X:     Train set
% i&j:   The labels of this prediction
% Y:     The classification results of the train set.
% -----------------------------------------------------------
% Output:
% w:     The coefficient of the model
% b:     The threshold value of the model
% t:     The label which represents the classification way
% -----------------------------------------------------------
% Author:
% Diliao Xu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Find two labels for binary classification.
yy = unique(Y);

% Separate the two types of data.
x1 = X((Y==yy(1)),:);
x2 = X((Y==yy(2)),:);

% Calculate the expectation of two types of train set data.
mu_1 = mean(x1,1);
mu_2 = mean(x2,1);

% Find the covariance matrix (Sigma_1 and Sigma_2).
d1 = x1-repmat(mu_1,size(x1,1),1);
d2 = x2-repmat(mu_2,size(x2,1),1);
Sigma1 = d1'*d1;
Sigma2 = d2'*d2;

% Find the within-class scatter matrix.
S_w = Sigma1+Sigma2;

% Find the between-class scatter matrix.
S_b = (mu_1-mu_2)*(mu_1-mu_2)';

% Calculate the coefficient of the model.
w = pinv(S_w)*(mu_1-mu_2)';

% Get the threshold.
s1 = sum(x1*w)/size(x1,1);
s2 = sum(x2*w)/size(x2,1);
b = -(s1+s2)/2;

% Decide the label helps the test set prediction.
if mu_1*w+b > 0
    t = 1;
else 
    t = 0;
end



