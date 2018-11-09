function [loss,gradient]=hinge(w,xTr,yTr,lambda)
% CHANGED!
%function [loss,gradient,preds]=hinge(w,xTr,yTr,lambda)
% function w=ridge(xTr,yTr,lambda)
%
% INPUT:
% xTr dxn matrix (each column is an input vector)
% yTr 1xn matrix (each entry is a label)
% lambda regression constant
% w weight vector (default w=0)
%
% OUTPUTS:
%
% loss = the total loss obtained with w on xTr and yTr
% gradient = the gradient at w
%

[d,n]=size(xTr);
fxy=(w'*xTr).*yTr;
%loss=sum((1-fxy).*(fxy<=1))/n;
%gradient=sum(gradientMat,2)/n;
loss=sum((1-fxy).*(fxy<=1))+lambda*w'*w;
gradientMat=-yTr.*xTr;  gradientMat(:,fxy>1)=0;
gradient=sum(gradientMat,2)+2*lambda*w;
%{
'sq loss:'
(w'*xTr-yTr)*(w'*xTr-yTr)'
'regu:'
lambda*w'*w
%}