function ans = tr4(trdata,test)
% ---------------------------------------------------
% Input:
% trdata        - trainning set
% test          - test set
% Output:
% ans           - the prediction result of test set. 
% ---------------------------------------------------
%% 训练模型
w = cell(10);
b = zeros(10,10);
t = zeros(10,10);
for i =1:9
    for j = i+1:10
        label = [(i-1)*ones(size(trdata{i},1),1);(j-1)*ones(size(trdata{j},1),1)]; % 整合标签数据
        trmatrix = [trdata{i};trdata{j}]; % 整合属性值
        [w{i,j},b(i,j),t(i,j)] = LDAtr(trmatrix,label);
    end
end

% 清除变量
clear trmatrix;

%% 测试训练集的数据
% 将45个分类器全部用在每个样本中，并在result中记录相应的分类结果
result = [];
for i =1:9
    for j = i+1:10
        yt = LDAte(w{i,j},b(i,j),test(:,2:end),i,j,t(i,j));
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


        




