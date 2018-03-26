clc;
clear;

load data.mat;

% Record the train set, and separate data of 0 ~ 9 
% trdata {i} refers to the data of "i-1" original data set
trdata = cell(10,1);
for i = 1:10
    trdata{i} = train(find(train(:,1)==i-1),2:end);
end


%% The results with SVM algorithm of different kinds of kernels

disp("--------------------------------------------");
% linear kernel:
disp('Linear kernel:');
tr1(trdata,test);
% polynomial kernel:
disp('Polynomial kernel:');
ans = tr2(trdata,test);
% RBF kernel:
disp('RBF kernel:');
tr3(trdata,test);
disp("--------------------------------------------");

%% Classification of the LDA.
disp('LDA method:');
tr4(trdata,test);
disp("--------------------------------------------");



%% The results of different kernels and their different parameters.
% You should change the paremeter in "training2()" or "kernel.m" and test
% sometimes.
tic
C = [0.01,0.1,1,3,5];
% Linear kernel:
disp("When there is linear kernel:")
for i = 1:length(C)
    fprintf("C = %d    ",C(i)); 
    tr5(trdata,test,'linear',C(i));
end
toc
fprintf("\n");

% Polynomial kernel:
disp("When there is polynomial kernel:")
for i = 1:length(C)
    fprintf("C = %d    ",C(i)); 
    tr5(trdata,test,'polynomial',C(i));
end

fprintf("\n");

% rbf kernel:
disp("When there is rbf kernel:")
for i = 1:length(C)
    fprintf("C = %.2f    ",C(i)); 
    tr5(trdata,test,'rbf',C(i));
end
disp("--------------------------------------------");

clear;

%% Data processing

load data.mat;

% Dimensionality reduction.
% Combine the training set with the test set.
data = [train;test];
data = data(:,2:end);

% set some dimensions for testing the model.
d = [10,30,50,100,150,170];

% PCA is "Principal Component Analysis".
% We can get the covariance matrix.
[~,W] = PCA(data,10); 

for i = 1:length(d)
    data = W(:,1:d(i));
    
    fprintf("d = %d:\n",d(i));
    % Get a new training set and test set.
    train = [train(:,1),data(1:size(train,1),:)];
    test = [test(:,1),data(size(train,1)+1:end,:)];
    
    % Get the results.
    training(train,test);
    
end

disp("--------------------------------------------");

clear;

%% GUI
% Although it will appear errors, it can still run and predict.

F2();

