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

%% ѵ��ģ��
% ����һ��cell�洢45��ѵ��ģ��
tr = cell(10);
w = cell(10);
b = zeros(10,10);
t = zeros(10,10);
for i =1:9
    for j = i+1:10
        label = [(i-1)*ones(size(trdata{i},1),1);(j-1)*ones(size(trdata{j},1),1)]; % ���ϱ�ǩ����
        trmatrix = [trdata{i};trdata{j}]; % ��������ֵ
        % ѵ��ģ�ͣ�
        tr{i,j} = fitcsvm(trmatrix,label,'Standardize',true,'KernelFunction','polynomial','KernelScale',14,'polynomialorder',4);
        % tr{i,j} = svmtrain(trmatrix,label,'kernel_function','rbf','rbf_sigma',16); % 94.17
        [w{i,j},b(i,j),t(i,j)] = LDAtr(trmatrix,label);
    end
end

% �������
clear trmatrix;

%% ����ѵ����������
% ��45��������ȫ������ÿ�������У�����result�м�¼��Ӧ�ķ�����
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

% �������
clear i;
clear j;
clear yt;

% ����ͶƱ���õ�ÿ�����������п��ܵķ���ֵ
ans1 = mode(result1,2);
ans2 = mode(result2,2);
% ����������ȷ��ratio
ratio = zeros(1,2);
% c��һ����¼Ŀ��ֵ��Ԥ��ֵ֮��ľ���
c = ans1-test(:,1); 
ratio(1) = (size(c(find(c(:)==0)),1))/size(test,1);
% �����ȷ��
fprintf('SVM:   %.2f %%\n', ratio(1)*100);

c = ans2-test(:,1); 
ratio(2) = (size(c(find(c(:)==0)),1))/size(test,1);
% �����ȷ��
fprintf('LDA:   %.2f %%\n\n', ratio(2)*100);
disp('-----------------------');
end
