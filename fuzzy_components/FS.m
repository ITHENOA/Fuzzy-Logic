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
        function ystar = with_CA(x,rules,mf)
            % Defuzzifier:  Center Average (CA)
            % Fuzzifier:    Singleton
            % FIS:          Product
            
            % fis = FIS.Product;
            % fis.defuzzifier = 'COA';
            % fis.fuzzifier = 'single';
            
            % mu(x)->singleton ==> muA(x) == t[mu(x),muA]
            A = FIS.Product(x,rules,mf);
            ystar = Defuzzifier.COA(ybar,A);
        end

        % FS with max defuzzifier
        function with_max()
        end
    end

end