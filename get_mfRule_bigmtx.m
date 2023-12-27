function mfRule = get_mfRule_bigmtx(rule,MFs)
%   INPUT
% rule : (n_rule,[A1,...,An,B]) 
% MFs {n_dim}(1,n_mf(dim)) : created by @get_mf_bigmtx function
%
%   OUTPUT
% varargin : [A^1,A^2,...,A^n,B]
%             A^1 : [(A1)^1,(A2)^1,(An)^1] : (objective)

for i = 1:numel(MFs)
    mfRule(:,i) = MFs{i}(rule(:,i));
end

