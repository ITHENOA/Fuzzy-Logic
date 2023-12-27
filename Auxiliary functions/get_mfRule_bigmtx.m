function mfRule = get_mfRule_bigmtx(rule,MF)
%   INPUT
% rule : (M,[A1,...,An,B]) : number of MFs
% MF :  mega MF matrix crated by (@get_mf_bigmtx) funciton
%
%   OUTPUT
% varargin : [A^1,A^2,...,A^n,B]
%             A^1 : [(A1)^1,(A2)^1,(An)^1] : (objective)

for i = 1:numel(MF)
    mfRule(:,i) = MF{i}(rule(:,i));
end

