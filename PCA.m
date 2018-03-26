function [W,P] = PCA(x,d)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: 
% To use Principal Component Analysis to realize data dimension reduction.
% ----------------------------------------------------------------------
% Usage:
% x = The original dataset.
% d = the quantity of trainsets' dimension.
% ----------------------------------------------------------------------
% Returns:
% P = Data set covariance matrix.
% W = Datasets after the dimension reduction.
% ----------------------------------------------------------------------
% Author:
% Diliao Xu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[a b] = size(x);

% Centralization.
X = x - repmat(mean(x),a,1);

% B = repmat(A,M,N) or B = repmat(A,[M,N]) creates a large matrix B 
% consisting of an M-by-N tiling of copies of A. If A is a matrix, 
% the size of B is [size(A,1)*M, size(A,2)*N].
C = X*X'/(a-1);

% Calculate the eigenvalue.
[p,q] = eig(C);

% Extract the elements of the diagonal matrix.
q1 = diag(q);

% Sort to select the d largest eigenvalues and corresponding eigenvectors.
[~,I] = sort(q1,'descend');
P = p(:,I);
W = P(:,1:d);
