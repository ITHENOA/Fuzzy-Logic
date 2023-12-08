%% Fuzzy Systems

classdef FS
    properties
    end

    methods

        % Constructor
        % function o = FS()
        % end

    end

    %% Useful Fuzzy Systems
    methods (Static)
        
        % FS with CA defuzzifier
        % function ystar = COAdefuzz(x,rules,mf)
        function ystar = COAdefuzz(xte,MFs,ybar)
            arguments
                xte
                MFs
                ybar (:,1)
            end
            % xte : (x_test) : (dim,#)
            % RuleMf : mega MF matrix crated by @RuleMf funciton
            % ybar : (1, n_rule(M)) : ybars of B
            n_x = size(xte,2);
            M = size(MFs,1);
            N = size(MFs,2) - 1;
            muAi = ones(M,n_x);
            for l = 1:M
                for i = 1:N
                    muAi(l,:) = muAi(l,:) .* MFs(l,i).membership(xte(i,:));
                end
                % p(l) = ybar(l) * muAi;
                % q(l) = 
            end
            ystar = sum(ybar .* muAi) ./ sum(muAi);

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Defuzzifier:  Center Average (CA)
            % Fuzzifier:    Singleton
            % FIS:          Product
            
            % fis = FIS.Product;
            % fis.defuzzifier = 'COA';
            % fis.fuzzifier = 'single';
            
            % mu(x)->singleton ==> muA(x) == t[mu(x),muA]
            % A = FIS.Product(x,rules,mf);
            % ystar = Defuzzifier.COA(ybar,A);
        end

        % FS with max defuzzifier
        function MAXdefuzz()
        end
    end

end