function bias=recoverBias(K,yTr,alphas,C);
% function bias=recoverBias(K,yTr,alphas,C);
%
% INPUT:	
% K : nxn kernel matrix
% yTr : nx1 input labels
% alphas  : nx1 vector or alpha values
% C : regularization constant
% 
% Output:
% bias : the hyperplane bias of the kernel SVM specified by alphas
%
% Solves for the hyperplane bias term, which is uniquely specified by the support vectors with alpha values
% 0<alpha<C
%

% YOUR CODE 
% SupportVecMask = alphas > eps & alphas < C - eps;
% FirstSupportVecIdx = find(SupportVecMask>0);
% bias = yTr(FirstSupportVecIdx) - K(FirstSupportVecIdx,:)*(yTr.*alphas);

% Choose the middle for stability
% Reference: https://www.mathworks.com/matlabcentral/answers/152301-find-closest-value-in-array
[~, MiddleSupportVecIdx] = min(abs(alphas - C/2));
bias = yTr(MiddleSupportVecIdx) - K(MiddleSupportVecIdx,:)*(yTr.*alphas);
