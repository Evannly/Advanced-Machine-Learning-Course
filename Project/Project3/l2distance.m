function D=l2distance(X,Z)
% function D=l2distance(X,Z)
%	
% Computes the Euclidean distance matrix. 
% Syntax:
% D=l2distance(X,Z)
% Input:
% X: dxn data matrix with n vectors (columns) of dimensionality d
% Z: dxm data matrix with m vectors (columns) of dimensionality d
%
% Output:
% Matrix D of size nxm 
% D(i,j) is the Euclidean distance of X(:,i) and Z(:,j)
%
% call with only one input:
% l2distance(X)=l2distance(X,X)
%

[d,n]=size(X);
if (nargin==1) % case when there is only one input (X)
	%% fill in code here
    G=X'*X;     s=diag(G);
    D=-2*G+s+s';D(D<0)=0;
    D=sqrt(D);
else  % case when there are two inputs (X,Z)
	%% fill in code here
    
    n=size(X,2);
    m=size(Z,2);
    %D=-2*X'*Z+diag(X'*X)+diag(Z'*Z)';
    n=size(X,2);
    m=size(Z,2);
    D=repmat(sum(X.^2,1)',1,m)+repmat(sum(Z.^2,1),n,1)-2*X'*Z;
    %D=-2*X'*Z+sum(X.^2,1)'+sum(Z.^2,1);
    D(D<0)=0;
    D=sqrt(D);
    
end;





