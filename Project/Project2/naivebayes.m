function logratio = naivebayes(x,y,x1)
% function logratio = naivebayes(x,y);
%
% Computation of log P(Y|X=x1) using Bayes Rule
% Input:
% x : n input vectors of d dimensions (dxn)
% y : n labels (-1 or +1)
% x1: input vector of d dimensions (dx1)
%
% Output:
% logratio: log (P(Y = 1|X=x1)/P(Y=-1|X=x1))

[d,n] = size(x);
%% fill in code here
m = sum(x1);
[pos,neg] = naivebayesPY(x,y);
[posprob,negprob] = naivebayesPXY(x,y);
prob_x_yPos = prod(posprob)*factorial(m)/prod(factorial(x1));
prob_x_yNeg = prod(negprob)*factorial(m)/prod(factorial(x1));
logratio=log((prob_x_yPos*pos)/(prob_x_yNeg*neg));
