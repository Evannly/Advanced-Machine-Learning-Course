function [loss,gradient]=ridge(w,xTr,yTr,lambda)
% function w=ridge(xTr,yTr,lambda)
%
% INPUT:
% w weight vector (default w=0)
% xTr dxn matrix (each column is an input vector)
% yTr 1xn matrix (each entry is a label)
% lambda regression constant
%
% OUTPUTS:
% loss = the total loss obtained with w on xTr and yTr
% gradient = the gradient at w
%

% loss=sum{(w'xi-yi)^2}/N+lambda*w'*w
% dloss/dw=sum{2*xi*(w'xi-yi)}/N+2*lambda+w
[d,n]=size(xTr);
%loss=sum((w'*xTr-yTr).^2)/n+lambda*w'*w;
%gradient=2*sum(xTr.*(w'*xTr-yTr),2)/n+2*lambda*w;
%loss=sum((w'*xTr-yTr).^2)+lambda*w'*w;
loss=(w'*xTr-yTr)*(w'*xTr-yTr)'+lambda*w'*w;
gradient=2*xTr*(w'*xTr-yTr)'+2*lambda*w;

% 'sq loss:'
% (w'*xTr-yTr)*(w'*xTr-yTr)'
% 'regu:'
% lambda*w'*w
