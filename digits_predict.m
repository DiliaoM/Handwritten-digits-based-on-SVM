function ans = digits_predict(q)
% ---------------------------------------------------
% Gogl:
%      Data prepocessing and predict.
% Input:
% q             - Image matrix
% Output:
% ans           - the prediction result of test set. 
% ---------------------------------------------------


load model.mat;               % 模型数据
% imag = imread(filename);      % 读取图片

imag = im2double(q);          % 转为double型矩阵
imag = rgb2gray(imag);        % 灰度化
imag = imbinarize(imag);      % 二值化(代替im2bw）
s = imresize(imag,[16,16]);   % 压缩图片
imshow(s);                    % 显示图片
s = standardize(s);           % 标准化
s = s';
s = reshape(s,[1,256]);       % 变为一行样本

result = [];                  % 记录分类结果
for i =1:9
    for j = i+1:10
        yt = svmclassify(tr{i,j},s);
        result = [result,yt];
    end
end

% 投票法找出出现频率最高的分类
ans = mode(result);