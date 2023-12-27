function par = get_mf_par(U,centers,mf_type,comp_const)
% INPUT
    % U : dimension boundaries [bound(x1);bound(x2);...;bound(xn);bound(y)] : bound(x) = [lb,ub]
    % centers : center of membership functions for each dimension (cell array {})
    % mf_type : type of required mf
    % comp_const (logical) : compliteness and consistanty
% OUTPUT
    % par (cell) : parameters of mfs : {n_dim}(n_mf,pars)
    
dim = size(U,1);
if comp_const
    switch lower(mf_type)
        case {'tri','triangular'}
            par = cell(1,dim);
            for d = 1:dim
                n_mf = numel(centers{d});
                for i = 1:n_mf
                    if i == 1
                        a = U(d,1);
                        b = centers{d}(1);
                        c = centers{d}(2);
                    elseif i == n_mf
                        a = centers{d}(end-1);
                        b = centers{d}(end);
                        c = U(d,2);
                    else
                        a = centers{d}(i-1);
                        b = centers{d}(i);
                        c = centers{d}(i+1);
                    end
                    par{d}(i,:) = [a b c];
                end
            end
        otherwise
            error('Enter Valid Type.')
    end
end
