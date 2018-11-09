clear all;
addpath('data');
load data_train.mat;
valsplit;
trainspamfilter(xTr,yTr);
%[fpr,tpr,auc]=spamfilter(xTv,yTv,thresh)
[fpr,tpr,auc]=spamfilter(xTv,yTv);
%pause
%vis_spam