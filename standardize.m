function R = standardize(A)
% ---------------------------------
% Input:
% A   -   a matrix which needs to be standardized.
% Output:
% R   -   a matrix after standarization.
% ---------------------------------
a = max(max(A));
b = min(min(A));
R = -1+2*(A-b)./(a-b);
