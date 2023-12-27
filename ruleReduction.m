function [new_rules, deg, newdeg] = ruleReduction(old_rules, star_value)
%   INPUT
% old_rules (n_rule,[x1,...,xn,y]) 
% star_value (size(old_rules)) : value of each part active with
%
%   OUTPUT
% new_rules (n_newRules,[x1,...,xn,y])
% deg (n_newRule,1) : degree of each rule : prod(muA)*muB
% newdeg (n_newRule,1) : new degree of each rule : deg*(n_repeat_THEN_part / n_repeat_IF_part)

% degree of rule
deg = prod(star_value, 2);
% new deg
m = length(deg);
newdeg = zeros(m, 1);

for i = 1:m
    newdeg(i, :) = deg(i) * sum(old_rules(:, end) == old_rules(i, end)) / sum(prod(old_rules(:, 1:end - 1) == old_rules(i, 1:end - 1), 2));
end

% choose rules
mix = [old_rules newdeg];
new_rules = zeros(m, size(mix, 2));
k = 0;

while ~isempty(mix)
    k = k + 1;
    temp = find(prod(mix(:, 1:end - 2) == mix(1, 1:end - 2), 2));
    [~, idx] = max(mix(temp, end));
    new_rules(k, :) = mix(temp(idx), :);
    mix(temp, :) = [];
    temp = [];
end

new_rules(k + 1:end, :) = [];
new_rules(:, end) = [];
end
