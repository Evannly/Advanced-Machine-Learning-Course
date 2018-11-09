function [bestC,bestP,bestval,allvalerrs]=crossvalidate(xTr,yTr,ktype,Cs,paras)
% function [bestC,bestP,bestval,allvalerrs]=crossvalidate(xTr,yTr,ktype,Cs,paras)
%
% INPUT:	
% xTr : dxn input vectors
% yTr : 1xn input labels
% ktype : (linear, rbf, polynomial)
% Cs   : interval of regularization constant that should be tried out
% paras: interval of kernel parameters that should be tried out
% 
% Output:
% bestC: best performing constant C
% bestP: best performing kernel parameter
% bestval: best performing validation error
% allvalerrs: a matrix where allvalerrs(i,j) is the validation error with parameters Cs(i) and paras(j)
%
% Trains an SVM classifier for all possible parameter settings in Cs and paras and identifies the best setting on a
% validation split. 
%

%%% Feel free to delete this
%bestC=0;
%bestP=0;
%bestval=10^10;

%% Split off validation data set
% Make y col
if size(yTr,1)<size(yTr,2) yTr=yTr'; end

foldNum = 10;
trainCount = max(size(yTr));
trainSetsX = {};    trainSetsY = {};
vaildSetsX = {};    vaildSetsY = {};
validSize = floor(trainCount/foldNum);
for foldidx=1:foldNum
    vaildIdxStart = (foldidx-1)*validSize+1;
    vaildIdxEnd = min(foldidx*validSize,trainCount);
    vaildSetsX{foldidx} = xTr(:,vaildIdxStart:vaildIdxEnd);
    vaildSetsY{foldidx} = yTr(vaildIdxStart:vaildIdxEnd);
    trainSetsX{foldidx} = xTr(:,[1:vaildIdxStart-1 vaildIdxEnd:end]);
    trainSetsY{foldidx} = yTr([1:vaildIdxStart-1 vaildIdxEnd:end]);    
end

%% Evaluate all parameter settings
% YOUR CODE
cNum = max(size(Cs));
paraNum = max(size(paras));
allvalerrs = zeros(cNum, paraNum);
% classifiers = {};
% lowestERate = 2;

optimoptions(@quadprog,'Display','off');
options = optimset('Display', 'off');
for cIdx = 1:cNum
    for paraIdx = 1:paraNum
        % evaluate 10-fold validation error for given C and para
        errorSum = 0;
        for foldIdx = 1:foldNum            
            K = computeK(ktype, trainSetsX{foldIdx}, trainSetsX{foldIdx}, paras(paraIdx));
            [H,q,Aeq,beq,lb,ub]=generateQP(K,trainSetsY{foldIdx},Cs(cIdx));
            alphas = quadprog(H,q,[],[],Aeq,beq,lb,ub, [], options);
            bias = recoverBias(K,trainSetsY{foldIdx},alphas,Cs(cIdx));
            svmclassify = @(xVa)(sign(  (trainSetsY{foldIdx}.*alphas)'*computeK(ktype, trainSetsX{foldIdx}, xVa, paras(paraIdx)) + bias)  );
            vaildError = sum(svmclassify(vaildSetsX{foldIdx})~=vaildSetsY{foldIdx}')/length(vaildSetsY{foldIdx});
            errorSum = errorSum + vaildError;
        end
        allvalerrs(cIdx, paraIdx) = errorSum/foldNum;        
    end
end

%% Identify best setting
% YOUR CODE
[bestCIdx, bestParaIdx] = find(allvalerrs==min(min(allvalerrs)));
bestCs = Cs(bestCIdx);          bestC = bestCs(1);
bestPs = paras(bestParaIdx);    bestP = bestPs(1);
bestval = allvalerrs(bestCIdx(1), bestParaIdx(1));

