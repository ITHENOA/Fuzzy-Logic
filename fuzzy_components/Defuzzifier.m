%% Defuzzifiers

classdef Defuzzifier

    % properties
    % end

    % methods
    %     function o = Defuzzifier()
    %     end
    % end

    methods (Static)

        % Center Of Area (Gravity)
        % function ystar = COA(bounds,MFs)
        %     U = linspace(bounds(1),bounds(2),size(MFs,2));
        %     maxmfs = max(MFs,[],1);
        %     [~,idx] = min(abs(mean(maxmfs(maxmfs~=0))-maxmfs));
        %     ystar = U(idx);
        %       fekr konam rast va chapesh bayad barabar bashe
        % end

        % Bisector of Area
        % function ystar = BOA()
        % end

        % Center Average Difuzzifier (Center Of Area) (Centroid)
        function ystar = COA(centers, centers_value)
            arguments
                centers (1,:)
                centers_value (1,:) = ones(1,numel(centers))
            end
            ystar = sum(centers .* centers_value) / sum(centers_value);
            % if yster there isnt in resulotion ?
        end

        % Maximum
        function ystar = max(bounds,MFs,type)
            arguments
                bounds (1,2)
                MFs % (n_mf, resolution)
                type {mustBeTextScalar} = 'mean'
            end
            U = linspace(bounds(1),bounds(2),size(MFs,2));
            [maximums,idx] = max(MFs,[],2);
            switch lower(type)
                case "smallest"
                    [~,minidx] = min(maximums);
                    ystar = U(idx(minidx));
                case "largest"
                    [~,maxidx] = max(maximums);
                    ystar = U(idx(maxidx));
                case "mean"
                    [~,meanidx] = mean(maximums);
                    ystar = U(idx(meanidx));
                otherwise
                    error("Enter correct type names: {'smallest', 'largest', 'mean'}")
            end

        end

    end

end