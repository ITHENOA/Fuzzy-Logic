function [center, data_count] = useful_mf_center(data, membership_target, sigma, h)
% v1: only gaussian
[mm,nn] = size(data);
data_count = zeros(1,nn);
center = zeros(mm,nn);
for n = 1:nn
    x = sort(data(:,n));
    i=0;
    while ~isempty(x)
        i=i+1;
        interval = x(1):h:x(end);
        c=[];
        for j = 1:length(interval)
            c(j) = sum(MF('gauss',x,[interval(j),sigma]) > membership_target);
        end
        [~,idx]=max(c);
        center(i,n) = interval(idx);
        data_count(n) = data_count(n) +1;
        x(MF('gauss',x,[interval(idx),sigma]) > membership_target) = [];
    end
end