function  ans = training(train,test)
% ---------------------------------------------------
% Input:
% train         - trainning set
% test          - test set
% Output:
% ans           - the prediction result of test set. 
% ---------------------------------------------------

trdata = cell(10,1);
for i = 1:10
    trdata{i} = train(find(train(:,1)==i-1),2:end);
end

%% 训练模型
% 建立一个cell存储45个训练模型
tr = cell(10);
w = cell(10);
b = zeros(10,10);
t = zeros(10,10);
for i =1:9
    for j = i+1:10
        label = [(i-1)*ones(size(trdata{i},1),1);(j-1)*ones(size(trdata{j},1),1)]; % 整合标签数据
        trmatrix = [trdata{i};trdata{j}]; % 整合属性值
        % 训练模型：
        tr{i,j} = fitcsvm(trmatrix,label,'Standardize',true,'KernelFunction','polynomial','KernelScale',14,'polynomialorder',4);
        % tr{i,j} = svmtrain(trmatrix,label,'kernel_function','rbf','rbf_sigma',16); % 94.17
        [w{i,j},b(i,j),t(i,j)] = LDAtr(trmatrix,label);
    end
end

% 清除变量
clear trmatrix;

%% 测试训练集的数据
% 将45个分类器全部用在每个样本中，并在result中记录相应的分类结果
result1 = [];
result2 = [];

for i =1:9
    for j = i+1:10
        yt = predict(tr{i,j},test(:,2:end));
        % yt = svmclassify(tr{i,j},test(:,2:end));
        result1 = [result1,yt];
        yt = LDAte(w{i,j},b(i,j),test(:,2:end),i,j,t(i,j));
        result2 = [result2,yt];
    end
end

% 清除变量
clear i;
clear j;
clear yt;

% 根据投票法得到每个样本中最有可能的分类值
ans1 = mode(result1,2);
ans2 = mode(result2,2);
% 计算分类的正确率ratio
ratio = zeros(1,2);
% c是一个记录目标值和预测值之差的矩阵
c = ans1-test(:,1); 
ratio(1) = (size(c(find(c(:)==0)),1))/size(test,1);
% 输出正确率
fprintf('SVM:   %.2f %%\n', ratio(1)*100);

c = ans2-test(:,1); 
ratio(2) = (size(c(find(c(:)==0)),1))/size(test,1);
% 输出正确率
fprintf('LDA:   %.2f %%\n\n', ratio(2)*100);
disp('-----------------------');
end
