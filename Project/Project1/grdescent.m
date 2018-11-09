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

if nargin<5,tolerance=1e-05;end;
w=w0;
loss_prev=inf;
for iter=1:maxiter
    [loss,gradient]=func(w);
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
end

%% (w_prev-w) version
%{
if nargin<5,tolerance=1e-05;end;
w=w0;
%w_prev=ones(size(w0));
for iter=1:maxiter
    [~,gradient]=func(w);
    w=w-stepsize*gradient;    
    if (norm(w_prev-w)<tolerance)
        break;
    end
    w_prev=w;
end
%}