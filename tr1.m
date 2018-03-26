function ratio = tr1(trdata,test)
% ---------------------------------------------------
% Input:
% trdata        - trainning set
% test          - test set
% Output:
% ans           - the prediction result of test set. 
% ---------------------------------------------------
%% 训练模型
tr = cell(10);% 建立一个cell存储45个训练模型
for i =1:9
    for j = i+1:10
        label = [(i-1)*ones(size(trdata{i},1),1);(j-1)*ones(size(trdata{j},1),1)]; % 整合标签数据
        trmatrix = [trdata{i};trdata{j}]; % 整合属性值
        % 训练模型：
        % tr{i,j} = svmtrain(trmatrix,label,'kernel_function','linear'); % 93.17
        tr{i,j} = fitcsvm(trmatrix,label,'Standardize',true,'KernelFunction','linear','KernelScale',14);
    end
end

% 清除变量
clear trmatrix;

%% 测试训练集的数据
% 将45个分类器全部用在每个样本中，并在result中记录相应的分类结果
result = [];
for i =1:9
    for j = i+1:10
        % yt = svmclassify(tr{i,j},test(:,2:end));
        yt = predict(tr{i,j},test(:,2:end));
        result = [result,yt];
    end
end

% 清除变量
clear i;
clear j;
clear yt;

% 根据投票法得到每个样本中最有可能的分类值
ans = mode(result,2);

% 计算分类的正确率ratio
% c是一个记录目标值和预测值之差的矩阵
c = ans-test(:,1); 
ratio = (size(c(find(c(:)==0)),1))/size(test,1);
% 输出正确率
fprintf('The accuracy rate is %.2f %%\n\n', ratio*100);

        




