classdef get_psudotrap_param
    % auto, normal, complete, consistent

    methods (Static)


        function [mf_param, xbar] = tri(U,n_mf)

            dimension = numel(n_mf);
            mf_param = ones(max(n_mf),4,dimension)*inf;
            xbar = ones(dimension,max(n_mf))*inf;

            for dim = 1:dimension
                xbar(dim,:) = U(dim,1):abs(U(dim,2) - U(dim,1))/(n_mf-1):U(dim,2);
                for part = 1:n_mf(dim)
                    if part == 1
                        mf_param(part,:,dim) = [xbar(dim,1),xbar(dim,1),xbar(dim,1),xbar(dim,2)];
                    elseif part == n_mf(dim)
                        mf_param(part,:,dim) = [xbar(dim,end-1),xbar(dim,end),xbar(dim,end),xbar(dim,end)];
                    else
                        mf_param(part,:,dim) = [xbar(dim,part-1),xbar(dim,part),xbar(dim,part),xbar(dim,part+1)];
                    end
                end
            end
        end

    end

end