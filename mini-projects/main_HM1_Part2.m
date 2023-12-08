clear;clc
close all

%% INPUT
n_random_sample = 100;       % number of random data
train_test_persent = 50;    % train_test split

%   ------------------ Question 3 ------------------
%     n = 1;   % number of features
%     Ux = [0 10];
%     Uy = [-2 4];
%     
%     hh=500;
%     xx = [linspace(0,10,hh)]';
%     yy = linspace(-2,4,hh)';
%     xy=[xx yy];
%   ------------------------------------------------

% %   ------------------ Question 4 ------------------
%     n = 2;                  % number of features
%     Ux = [-4 4 ; -5 5];     % inputs interval
%     Uy = [-10 25];          % output interval
% 
%     hh=500;
%     xx = [linspace(-4,4,hh); linspace(-5,5,hh)]';
%     yy = linspace(-10,25,hh)';
%     xy=[xx yy];
% %   ------------------------------------------------

%   ------------------ Question ??? ------------------
    n = 1;                  % number of features
    Ux = [0 10];     % inputs interval
    Uy = [-1.2 0];          % output interval
    
    hh=500;
    xx = [linspace(0,10,hh)]';
    yy = linspace(-1.2,0,hh)';
    xy=[xx yy];
    f = @(x) -pi/6*sin(x+3*pi/2)-pi/6;
%   ------------------------------------------------

%% RANDOM DATA --> TEST/TRAIN
rng(5);     % Fixed random seed

%   ------------------ Question 3 -----------------
    x_sample = (xx(end)+abs(xx(1)))*rand(1,n_random_sample) - abs(xx(1));
%   ------------------------------------------------

%   ------------------ Question 4 ------------------
    % x1 = -4 + 8*rand(n_random_sample, 1);
    % x2 = -5 + 10*rand(n_random_sample, 1);
    % x_sample = [x1';x2'];
%   ------------------------------------------------


% Randomly divide the sample set into two equal training and testing datasets
idx = randperm(n_random_sample);
train_idx = idx(1:n_random_sample*train_test_persent/100);
test_idx = idx(n_random_sample*train_test_persent/100+1:n_random_sample);

% Create train and test data
X_train = x_sample(:,train_idx)';
y_train = f(X_train);
X_test = x_sample(:,test_idx)';
y_test = f(X_test);

% Mix inputs and outputs:  x1, x2, ..., y --> data
data_train = [X_train,y_train];
n_data_train = length(data_train);
data_test = [X_test,y_test];
n_data_test = length(data_test);

%% CHOOSE MEMBERSHIP FUNCTION (MF)

%%% /// Find center ///

%%%%  ----- Method 1: for the hole interval -----
h=1;
U = [Ux' Uy'];
interval_divider = abs(U(2,:)-U(1,:))/h;
N = round(interval_divider) + 1; % number of MFs
center = zeros(max(interval_divider),n);
for nn = 1:n+1 % number of features
    for j = 1:interval_divider(nn)+1
        center(j,nn) = U(1,nn)+(j-1)*h; % find centers of mfx
    end
end

%%%%  ----- Method 2: choose useful mf -----
% membership_target = .6;  % Minimum amount of train_data membership 
% sigma = 1;
% h = .1;
% [center,N] = useful_mf_center(data_train,membership_target,sigma,h);
% table(N)


%%% /// CREATE MFs ///
sigma = 1;
MFs{max(N),n+1}=0;
for nn = 1:n+1
    for i = 1:N(nn)
        MFs{i,nn} = @(x) MF('gauss', x, [center(i,nn), sigma]);
    end
end


%% TRAIN
mfs = zeros(n_data_train,sum(N));
k=0;

for nn = 1:n+1 % n
    for i = 1:N(nn) % mu
        k=k+1;
        for j = 1:n_data_train % data
            mfs(j,k) = MFs{i,nn}(data_train(j,nn)); %MF(mf_type, data_train(j,nn), [center(i,nn), sigma]);
        end
    end
end


%% CHOOSE RULEs
%%%  ----- Method 1: for each data one rule -----
% A* and B* --> maximum MF for each x_train
% if x is Astar(1:20) then y is Bstar(1:20)
% for each train data have a rule --> too much
k=0;
temp = [0 N];
star = zeros(n_data_train,n+1); rules = star;
for nn = 1:n+1
    for i = 2:n+2
        [star(:,i-1),rules(:,i-1)] = max(mfs(:,sum(temp(1:i-1))+1:sum(temp(1:i))),[],2);
    end
end
% star: [A1*, A2*, ..., An*, B*]
% rules: the number of star --> rules

%%%  ----- Method 2: find useful Rules -----
[new_rules,deg,newdeg] = useful_Rules(rules,star);    % useful rules (find with degree of rules)

NO = (1:length(rules))';
table(NO,rules,deg,newdeg)
NO = (1:length(new_rules))';
table(NO,new_rules)

%% FUZZY SYSTEM
% ( product inference engine, Triangular fuzzifier, center average defuzzifier )
% X_test = [x1 x2]
y_pred = fuzzySystem(X_test,new_rules,center,MFs);

table(y_test, y_pred)

%% ACCURACY
err = sum((y_test - y_pred).^2);
% Root Mean Squared
RMS = sqrt(err/n_data_test)
% Mean Squared Error
MSE = err/n_data_test

%% PLOTs

%%% MFs PLOT
figure(1)
for nn = 1:n+1
    subplot(n+1,1,nn)
for i=1:N(nn); plot(xy(:,nn),MFs{i,nn}(xy(:,nn)));hold on; end
scatter(data_test(:,nn),.1,'r')
scatter(data_train(:,nn),0,'b')
end

%   ------------------ Question 3 ------------------
    figure(2)
    %%% plot
    subplot(121)
    plot(xx, f(xx))
    hold on
%%%     scatter(X_train,y_train,'b')
%%%     scatter(X_test,y_test,'^','r')
%%%     legend('','train','test')
    plot(xx, fuzzySystem(xx, new_rules, center, MFs))
    legend('Actual','Predicted')

    %%% scatter
    subplot(122)
    scatter(X_test, y_test)
    hold on
    scatter(X_test, y_pred, 'x')
    legend('Actual','Predicted')
%   ------------------------------------------------

%   ------------------ Question 4 ------------------
%     figure(2)
%     %%% plot
%     subplot(121)
%     [X1,X2]=meshgrid(xx(:,1),xx(:,2));
%     y = @(x1,x2) 4*(2-X1).^2.*exp(-X1.^2-(X2-1).^2)-10*(X1/4-X1.^3-X2.^5).*exp(-X1.^2-X2.^2)-0.5*exp(-(X1+2).^2-X2.^2);
%     mesh(X1,X2,y(xx(:,1) ,xx(:,2)))
%     title('Actual')
%     subplot(122)
%     for i = 1:hh
%         for j = 1:hh
%             yp(i,j) = fuzzySystem([xx(i,1) xx(j,2)],new_rules,center,MFs);
%         end
%     end
%     mesh(X1,X2,yp)
%     title('Estimated')

    %%% scatter
%     figure
%     scatter3(X_test(:,1),X_test(:,2),y_test)
%     hold on
%     scatter3(X_test(:,1),X_test(:,2),y_pred,'x')
%     legend('Actual','Predicted')
%%%% scatter3(X_train(:,1),X_train(:,2),y_train); hold on
%%%% scatter3(X_test(:,1),X_test(:,2),y_test, '^')
%%%% legend('train','test')
%   ------------------------------------------------

% hold off

%% FUNCTIONS

%  ------------------ Question 3 ------------------
% function y = f(x)
% y = zeros(1,length(x));
% for i = 1:length(x)
%     if x(i) >= 0 && x(i) <= 5
%         y(i) = x(i) - 2;
%     elseif x(i) > 5 && x(i) <= 10
%         y(i) = 9 - x(i);
%     else
%         y(i) = 0;
%     end
% end
% y=y';
% end

%  ------------------ Question 4 ------------------
% function y = f(x)
% y = zeros(size(x,1),1);
% for i = 1:size(x,1)
%     y(i) = 4*(2-x(i,1))^2*exp(-x(i,1)^2-(x(i,2)-1)^2)-10*(x(i,1)/4-x(i,1)^3-x(i,1)^5)*exp(-x(i,1)^2-x(i,2)^2)-.5*exp(-(x(i,1)+2)^2-x(i,2)^2);
% %     for j=1:length(x)
% %         y(i,j) = 4*(2-x(1,i))^2*exp(-x(1,i)^2-(x(2,j)-1)^2)-10*(x(1,i)/4-x(1,i)^3-x(2,j)^5)*exp(-x(1,i)^2-x(2,j)^2)-.5*exp(-(x(1,i)+2)^2-x(2,j)^2);
% %     end
% end
% end

