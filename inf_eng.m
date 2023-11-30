%% Fuzzy Inference Engine

% (dim)     i = 1:N
% (rule)    l = 1:M

classdef inf_eng

    properties
        x
        A   % inputs MFs    A_i,l
        B   % output MFs    B_l
        imp
    end

    methods
        function o = inf_eng(x,A,B)
            o.x = x;
            o.A = A;
            o.B = B;
            o.imp = Implication(muxl,muyl);
        end
    end

    methods (Static)
        function Bp = Product(o)
            % individual-base with union combination
            % imp: mamdani product
            % tnorm: alg
            % snorm: max

            Implication(mux(1:l),muy(1:l)).Mamdani

        end
        function Bp = Min()
            % individual-base with union combination
            % imp: mamdani min
            % tnorm: min
            % snorm: max
        end
        function Bp = Lukasiewicz()
            % individual-base with intersect combination
            % imp: Lukasiewicz
            % tnorm: min

        end
        function Bp = Zadeh()
            % individual-base with intersect combination
            % imp: Zadeh
            % tnorm: min

        end
        % Dienes-Rescher
        function Bp = Rescher()
            % individual-base with intersect combination
            % imp: Rescher
            % tnorm: min

        end
    end
end