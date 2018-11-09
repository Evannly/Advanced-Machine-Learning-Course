function [w]=grdescent(func,w0,stepsize,maxiter,tolerance)
% function [w]=grdescent(func,w0,stepsize,maxiter,tolerance)
%
% INPUT:
% func function to minimize
% w0 = initial weight vector 
% stepsize = initial gradient descent stepsize 
% tolerance = if norm(gradient)<tolerance, it quits
%
% OUTPUTS:
% 
% w = final weight vector
%

if nargin<5,tolerance=1e-02;end;
% INSERT CODE HERE:
w=w0;
loss_prev=inf;
%grad_prev = 0;
% [~,grad_prev]=func(w);
for iter=1:maxiter
    [loss,gradient]=func(w);
%     func=@(w) deepnet(w,xTr,yTr,wst,TRANSNAME);
%     gradient = gradient*0.1 + grad_prev*0.9;
    if (norm(gradient)<tolerance)   
        break;
    elseif loss_prev<loss  % if loss increased
        stepsize=0.5*stepsize;
        w=w-stepsize*gradient;
    else                   % if loss still deceasing        
        stepsize=1.01*stepsize;
        w=w-stepsize*gradient;
    end
    loss_prev=loss;
    
%     grad_prev = gradient;
end

