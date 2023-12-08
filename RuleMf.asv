function MFs = RuleMf(rule,MF)

% rule : (M,[A1,...,An,B]) : number of MFs

% varargin : [A^1,A^2,...,A^n,B]
%             A^1 : [(A1)^1,(A2)^1,(An)^1] : (objective)

for i = 1:numel(MF)
    MFs(:,i) = MF{i}(rule(:,i));
end

