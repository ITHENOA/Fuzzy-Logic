%% Fuzzy Inference System (Engine)

% (dim)     i = 1:N
% (rule)    l = 1:M

classdef FIS

    properties
        x
        % A   % inputs MFs    A_i,l
        % B   % output MFs    B_l
        imp_type
        imp_par
        tn_type
        sn_type
        combination
    end

    methods
        function o = FIS()
            % o.x = x;
            % o.A = A;
            % o.B = B;
            % o.imp = Implication(muxl,muyl);
        end

        % function o = set_par(o,imp,tn,sn)
        %     o.imp = imp;
        %     o.tn = tn;
        %     o.sn = sn;
        % end

        function Bp = func(o,Ap,MFs)
            % rules : (n_rule(M), dim([A1, A2, ..., B]))
            % MFs : {n_rule, [A^1,...,A^l,B^l]}(1, resulotion)

            M = size(MFs,1);
            N = size(MFs,2) - 1;
            % Step 1 : tnorm(A1...An)
            A = ones(M,res);
            B = zeros(M,res);
            for l = 1:M
                for i = 1:N
                    A(l,:) = Tnorm(o.tn_type, A(l,:), MFs{l,i});
                end
                B(l,:) = MFs{l,end};
            end
            % Step 2 : implication(Al,Bl)
            R = Implication(A,B).set_knowntype(o.imp_type,o.imp_par);

            % Step 3 :

            % Individual-base
            switch o.base
                case 'individual'

                    Bpl = Tnorm(o.tn_type, R, Ap);
                    Bp = ones(1,M);
                    switch o.combination
                        case "intersection"
                            for i = 1:M
                                Bp = Tnorm(o.tn_type, Bp, Bpl(i,:));
                            end
                        case "union"
                            for i = 1:M
                                Bp = Snorm(o.sn_type, Bp, Bpl(i,:));
                            end
                        otherwise
                            error("Invalid combination type: {'intersection', 'union'}")
                    end

                case 'composition'

                    switch o.combination
                        case "mamdani"
                        case "godel"
                        otherwise
                            error("Invalid combination type: {'mamdani', 'godel'}")
                    end
                otherwise
                    error("Invalid base type: {'individual', 'composition'}")
            end

        end
    end

    methods (Static)
        function Bp = Product(Ap,rules,MFs)
            arguments
                Ap % {Ap-in-dim1(Ap1), Ap2, ..., Apn}
                rules % (n_rule(M), dim([A1, A2, ..., B]))
                MFs % class object (n_rule, [A^1,...,A^l,B^l])                         {dim1(x1), x2, ..., y} (n_mf, resulotion)
            end

            o = FIS();
            o.imp_type = 'mamdani';     % imp: mamdani product
            o.tn_type = 'alg';          % tnorm: alg
            o.sn_type = 'max';          % snorm: max
            o.base = 'individual';      % individual-base
            o.combination = 'union';    %union combination

            Bp = func(o,Ap,rules,MFs);


            % % for FS with COA
            % A = ones(1,M);
            % for l = 1:M
            %     for i = 1:N
            %         % MFs : class object (n_rule, [A^1,...,A^l,B^l])
            %         A(l) = A(l) * MFs(l,i).membership(Ap(i));
            %     end
            % end
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