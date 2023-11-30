classdef get_mf

    properties
        bounds
        n_mf
        xbar
        
    end

    methods

        function obj = get_mf(bounds, n_mf, xbar)
            obj.bounds = bounds;
            obj.n_mf = n_mf;
            obj.xbar = xbar;
        end

        function mf = triangular(obj,x)
            % consistence, complete, crosspoint=0.5
            % x: (dim,points)

            % mf = zeros(numel(x),obj.N);
            % mf = {1:size(x,2)};
            % mf = ones(max(obj.n_mf),size(x,2),size(x,1))*inf;
            % for dim = 1:size(x,1)
            %     for part = 1:obj.n_mf
            %         if part == 1
            %             mf(part,:,dim) = MF.tri(x, obj.xbar(1), obj.xbar(1), obj.xbar(2));
            %         elseif part == obj.n_mf
            %             mf{dim}(part,:,dim) = MF.tri(x, obj.xbar(end-1), obj.xbar(end), obj.xbar(end));
            %         else
            %             mf{dim}(part,:,dim) = MF.tri(x, obj.xbar(part-1), obj.xbar(part), obj.xbar(part+1));
            %         end
            %     end
            % end

            % for dim = 1:size(x,1)
                for part = 1:obj.n_mf
                    if part == 1
                        mf(:,part) = MF.tri(x, obj.xbar(1), obj.xbar(1), obj.xbar(2));
                    elseif part == obj.n_mf
                        mf(:,part) = MF.tri(x, obj.xbar(end-1), obj.xbar(end), obj.xbar(end));
                    else
                        mf(:,part) = MF.tri(x, obj.xbar(part-1), obj.xbar(part), obj.xbar(part+1));
                    end
                end
            % end

        end

    end

end