function MFs = get_mf_bigmtx(mf_type,par)
% INPUT
% par {n_dim}(n_mf(dim),mf_params) : from @get_mf_par function
% OUTPUT
% MFs {n_dim}(1,n_mf(dim))

dim = numel(par);
MFs = cell(1,dim);
for d = 1:dim
    MFs{d}(1:size(par{d},1)) = MF(mf_type);
    for j = 1:size(par{d},1) % n_mf in dim(d)
        % MFs{d}(j) = MF.Triangular(par{d}(j,:));
        MFs{d}(j).par = num2cell(par{d}(j,:));
    end
end