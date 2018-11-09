function svmclassify=autosvm(xTr,yTr)
%	function svmclassify=autosvm(xTr,yTr)
% INPUT:	
% xTr : dxn input vectors
% yTr : 1xn input labels
% 
% Output:
% svmclassify : a classifier (scmclassify(xTe) returns the predictions on xTe)
%
%
% Performs cross validation to train an SVM with optimal hyper-parameters on xTr,yTr
%
disp('Performing cross validation ...');

cRange1 = 2.^[-1:8];
parasRange1 = 2.^[-2:3];
[bestC1,bestP1,bestval1,allerrs1]=crossvalidate(xTr,yTr,'rbf',cRange1,parasRange1);

cRange2 = linspace(0.1*bestC1, 10*bestC1, 20);
parasRange2 = linspace(0.1*bestP1, 10*bestP1, 20);
[bestC2,bestP2,bestval2,allerrs2]=crossvalidate(xTr,yTr,'rbf',cRange2,parasRange2);

cRange3 = linspace(0.5*bestC2, 1.5*bestC2, 20);
parasRange3 = linspace(0.5*bestP2, 1.5*bestP2, 20);
[bestC,bestP,bestval,allerrs]=crossvalidate(xTr,yTr,'rbf',cRange3,parasRange3);

disp('Training SVM ...');
svmclassify=trainsvm(xTr,yTr,bestC,'rbf',bestP);
%testerror = sum(svmclassify(xTe)~=yTe)/length(yTe)
%visdecision(xTe,yTe,svmclassify,'vismargin',true);

% [xx,yy]=meshgrid(-2:3,-1:8);
% surf(xx,yy,allerrs1);
% xlabel('\gamma'); ylabel('C'); zlabel('Val Error');

