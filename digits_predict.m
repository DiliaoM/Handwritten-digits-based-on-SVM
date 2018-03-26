function ans = digits_predict(q)
% ---------------------------------------------------
% Gogl:
%      Data prepocessing and predict.
% Input:
% q             - Image matrix
% Output:
% ans           - the prediction result of test set. 
% ---------------------------------------------------


load model.mat;               % ģ������
% imag = imread(filename);      % ��ȡͼƬ

imag = im2double(q);          % תΪdouble�;���
imag = rgb2gray(imag);        % �ҶȻ�
imag = imbinarize(imag);      % ��ֵ��(����im2bw��
s = imresize(imag,[16,16]);   % ѹ��ͼƬ
imshow(s);                    % ��ʾͼƬ
s = standardize(s);           % ��׼��
s = s';
s = reshape(s,[1,256]);       % ��Ϊһ������

result = [];                  % ��¼������
for i =1:9
    for j = i+1:10
        yt = svmclassify(tr{i,j},s);
        result = [result,yt];
    end
end

% ͶƱ���ҳ�����Ƶ����ߵķ���
ans = mode(result);