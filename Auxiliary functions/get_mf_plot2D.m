function get_mf_plot2D(U,MFs,train_data,test_data)
% INPUT
    % U (n_dim,[ub,lb]) : boundaries
    % N (1,n_dim) : number of mf in each dim
    % MFs {1,n_dim} : created by @get_mf_bigmtx function
    % train_data (n_data,[x1,...,xn,y]) : train dataset
    % test_data (n_data,[x1,...,xn,y]) : test dataset
% OUTPUT
    % show plot

tr = true;
ts = true;
if nargin < 4
    ts = false;
    if nargin < 3
        tr = false;
    end
end

dim = size(U,1);
for d = 1:dim
    space = U(d,1):.01:U(d,2);
    subplot(dim, 1, d);
    for j = 1:numel(MFs{d})
        plot(space, MFs{d}(j).membership(space))
        hold on
    end
    if tr, scatter(train_data(:,d),0.2,'r','filled'), end
    if ts, scatter(test_data(:,d),0.2,'b','filled'), end
    if d == 1, title('Membership function of each dimension'), end
    if d ~= dim
        xlabel("X" + d)
    else
        xlabel('Y')
    end
    ylabel('Membership')
    xlim([U(d,1) U(d,2)])
    hold off
end
