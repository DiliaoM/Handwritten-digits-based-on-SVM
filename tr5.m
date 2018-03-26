function ratio = tr5(trdata,test,type,C)
% ---------------------------------------------------
% Input:
% trdata        - trainning set
% test          - test set
% Output:
% ans           - the prediction result of test set. 
% ---------------------------------------------------

%% ѵ��ģ��
w = cell(10);
b = zeros(10,10);
t = zeros(10,10);
tr = cell(10);% ����һ��cell�洢45��ѵ��ģ��
for i =1:9
    for j = i+1:10
        label = [(i-1)*ones(size(trdata{i},1),1);(j-1)*ones(size(trdata{j},1),1)]; % ���ϱ�ǩ����
        trmatrix = [trdata{i};trdata{j}]; % ��������ֵ
        tr{i,j} = SVMtr(trmatrix',label',type,C); 
    end
end

% �������
clear trmatrix;

%% ����ѵ����������
% ��45��������ȫ������ÿ�������У�����result�м�¼��Ӧ�ķ�����
result = [];
for i =1:9
    for j = i+1:10
        tee = test(:,2:end);
        yt = SVMte(tr{i,j},tee',type,i,j);
        result = [result,yt];
    end
end

% �������
clear i;
clear j;
clear yt;

% ����ͶƱ���õ�ÿ�����������п��ܵķ���ֵ
ans = mode(result,2);

% ����������ȷ��ratio
% c��һ����¼Ŀ��ֵ��Ԥ��ֵ֮��ľ���
c = ans-test(:,1); 
ratio = (size(c(find(c(:)==0)),1))/size(test,1);
% �����ȷ��
fprintf('The original accuracy rate is %.2f %%\n', ratio*100);