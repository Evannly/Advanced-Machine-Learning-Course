function [posprob,negprob] = naivebayesPXY(x,y)
% function [posprob,negprob] = naivebayesPXY(x,y);
%
% Computation of P(X|Y)
% Input:
% x : n input vectors of d dimensions (dxn)
% y : n labels (-1 or +1) (1xn)
%
% Output:
% posprob: probability vector of p(x|y=1) (dx1)
% negprob: probability vector of p(x|y=-1) (dx1)
%

% add one all-ones positive and negative example
[d,n]=size(x);
x=[x ones(d,2)];
y=[y -1 1];

[d,n] = size(x);
%% fill in code here
% factorial
%                          m!                     d   sum( (y==c)*(x(a,:)) )
% P(xi|m,y=c) =  -----------------------  *      I I  ----------------------
%                x(1,i)!x(2,i)!...x(d,i)!        a=1  sum( (y==c)*(sum(x)) )
% This function is computing the second half, i.e. 2 prob.s for each dimension
posprob=sum((y==1).*x,2)/sum(sum((y==1).*x));
negprob=sum((y==-1).*x,2)/sum(sum((y==-1).*x));