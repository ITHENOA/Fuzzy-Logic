function [rule, star_value] = get_rule(MFs,data_train)
%   INPUT
% MFs {n_dim}(1,n_mf(dim)) : created by @get_mf_bigmtx function
% data_train (n_data,[x1,...xn,y]) : [X_train, y_train]
%
%   OUTPUT
% rule (n_rule,[x1,...,xn,y])
% star_value (size(rule)) : value of each part active with

M = size(data_train,1); % number of first rules
N = size(data_train,2)-1; % number of input dimension
rule = zeros(M,N+1);
starXvalue = zeros(N,M);
starYvalue = zeros(1,M);
for l = 1:M
    % memberX = zeros(numel(MFs{dim}), N);
    for dim = 1:N
        for i = 1:numel(MFs{dim})
            memberX(i,dim) = MFs{dim}(i).membership(data_train(l,dim));
        end
    end
    % memberY = zeros(1,numel(MFs{end}));
    for i = 1:numel(MFs{end})
        memberY(i) = MFs{end}(i).membership(data_train(l,end));
    end
    % Step 1 : find must active MF for each train data (A* and B*)
    [starXvalue(:,l),starX] = max(memberX);
    [starYvalue(l),starY] = max(memberY);
    % Step 2 : create rules
    rule(l,:) = [starX, starY];    % IF x is A(starX) THEN y is B(starY)
end
star_value = [starXvalue;starYvalue]';