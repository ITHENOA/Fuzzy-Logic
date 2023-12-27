% Fuzzy Regression Vector (ksi)
function [ksi, phi] = fuzzRegVec(x,RuleMf)

%   INPUT
% x (dim,n_data) : input data : X_test
% RuleMf : mega MF matrix crated by (@RuleMf) function.
%
%   OUTPUT
% ksi (n_data, n_rule) : regression vector

M = size(RuleMf,1);    % n_rules
N = size(RuleMf,2);    % n_input_dim
x = reshape(x,N,[]);
n_x = size(x,2); 

Mu_l_d = zeros(M,N,n_x);
for l = 1:M  % Rules
    for d = 1:N  % Dimensions
        Mu_l_d(l,d,:) = RuleMf(l,d).membership(x(d,:));
    end
end

Mu_l = reshape(prod(Mu_l_d,2),M,n_x);   % (n_rule, n_data)
sum_Mu_l = sum(Mu_l);                   % (1, n_data)
ksi = Mu_l./sum_Mu_l;                   % (n_rule, n_data)
% phi = [ksi(data1)';ksi(data2)';...]
phi = ksi';                             % (n_data, n_rule)  