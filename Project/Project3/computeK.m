function K = computeK(kernel_type, X, Z, param)
% function K = computeK(kernel_type, X, Z)
% computes a matrix K such that Kij=g(x,z);
% for three different function linear, rbf or polynomial.
%
% Input:
% kernel_type: either 'linear','polynomial','rbf'
% X: n input vectors of dimension d (dxn);
% Z: m input vectors of dimension d (dxm);
% param: kernel parameter (inverse kernel width gamma in case of RBF, degree in case of polynomial)
%
% OUTPUT:
% K : nxm kernel matrix
%
%

if nargin<2,
	Z=X;
end;

%%YOUR CODE HERE
if strcmp(kernel_type,'linear')
    K = X'*Z;
elseif strcmp(kernel_type,'polynomial') || strcmp(kernel_type,'poly')
    p = param;
    K = (X'*Z+1).^p;
elseif strcmp(kernel_type,'rbf')
    gamma = param;
    K = exp( -gamma*l2distance(X,Z).^2 );
end

%{
[d,n] = size(X);
[d,m] = size(Z);
K = zeros(n,m);
if kernel_type == 'linear'
    for i = 1:n
        for j = 1:m
            K(i,j) = X(:,i)'*Z(:,j);
        end
    end
elseif kernel_type == 'polynomial' || kernel_type == 'poly'
    p = param;
    for i = 1:n
        for j = 1:m
            K(i,j) = ( X(:,i)'*Z(:,j) )^p;
        end
    end
elseif kernel_type == 'rbf'
    gamma = param;
    for i = 1:n
        for j = 1:m
            K(i,j) = exp( -gamma*norm( X(:,i)-Z(:,j) )^2 );
        end
    end
end
%}
