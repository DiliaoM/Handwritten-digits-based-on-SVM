function y = LDAte(w,b,X,i,j,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: 
% Predict the value of the test set with models learning by training set. 
% -----------------------------------
% Input:
% w:     The coefficient of the model
% b:     The threshold value of the model
% X:     Test set
% i&j:   The labels of this prediction
% t:     The label which represents the classification way
% -----------------------------------
% Output:
% y:     Prediction results
% -----------------------------------
% Author:
% Diliao Xu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The results of the model.
y = X*w + b;

% Decide which label should be used.
if t==1
    y(find(y>=0)) = i-1;
    y(find(y<0))=j-1;
else
    y(find(y>=0)) = j-1;
    y(find(y<0)) = i-1;
end

