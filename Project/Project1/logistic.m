function [loss,gradient]=logistic(w,xTr,yTr)
% function w=logistic(w,xTr,yTr)
%
% INPUT:
% xTr dxn matrix (each column is an input vector)
% yTr 1xn matrix (each entry is a label)
% w weight vector (default w=0)
%
% OUTPUTS:
% 
% loss = the total loss obtained with w on xTr and yTr
% gradient = the gradient at w
%

[d,n]=size(xTr);
e=exp(1);
fxy=(w'*xTr).*yTr;
%loss=sum(log(1+e.^(-fxy)))/n;
loss=sum(log(1+e.^(-fxy)));

grad_denom_vec=1+e.^fxy;
grad_nomin_mat=yTr.*xTr;
%gradient=sum(-(grad_nomin_mat./grad_denom_vec),2)/n;
gradient=sum(-(grad_nomin_mat./grad_denom_vec),2);