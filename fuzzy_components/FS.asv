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

        function  ystar = optimal(xte,yte,mf_type,distance)
            n_data = numel(yte);
            xte = reshape(xte,n_data,[]);
            yte = reshape(yte,[],1);
            
            par = get_systematic_par(mf_type,[xte yte],distance);
            MFs = get_mf_bigmtx(mf_type,par);
            rule = (1:n_data)' .* ones(n_data,size(xte,2)+1);
            RuleMF = get_mfRule_bigmtx(rule,MFs);
            ystar = FS.COAdefuzz(xte,RuleMF,yte);
        end
        
        % FS with CA defuzzifier
        % function ystar = COAdefuzz(x,rules,mf)
        function ystar = COAdefuzz(xte,RuleMf,ybar)
            arguments
                xte         % (x_test) : (n_dim,n_data)or
                RuleMf      % mega MF matrix crated by (@get_mfRule_bigmtx) funciton
                ybar (:,1)  % (1, n_rule(M)) : ybars of B
            end
            % n_x = size(xte,2);
            % M = size(MFs,1);
            % N = size(MFs,2) - 1;
            % muAi = ones(M,n_x);
            % for l = 1:M
            %     for i = 1:N
            %         muAi(l,:) = muAi(l,:) .* MFs(l,i).membership(xte(i,:));
            %     end
            % end
            % ystar = sum(ybar .* muAi) ./ sum(muAi);

            ksi = fuzzRegVec(xte,RuleMf(:,1:size(xte,2)));
            ystar = ybar' * ksi;

            % missing ybar
            % tta = inv(phi'*phi) * phi' * y_train;
            % ystar = tta' * ksi;

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