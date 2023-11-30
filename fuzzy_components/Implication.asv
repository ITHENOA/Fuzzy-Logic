%% Implication

% p -> q : 
%       - option 1: union( complement(p), q )
%       - option 2: union( intersection(p,q), complement(p) )

% usage
%   1. Implication(mux,muy).mamdani()
%   2. Implication(mux,muy).set_knowntype('mamdani',par(if need))
%   3. Implication(mux,muy).custom(option, 'basic', [], 'max', [], 'min', [])

% ITHENOA Nov-29-2023

classdef Implication
    properties
        mux
        muy
    end

    methods

        function obj = Implication(mux, muy)
            obj.mux = mux;
            obj.muy = muy;
        end

        % systematicaly use known type
        function rel = set_knowntype(obj, type, par)
            switch type
                case 'rescher'
                    rel = obj.Rescher();
                case 'lukasiewicz'
                    rel = obj.Lukasiewicz();
                case 'zadeh'
                    rel = obj.Zadeh();
                case 'godel'
                    rel = obj.Godel();
                case 'mamdani'
                    rel = obj.Mamdani(par);
            end
        end

        % Custom
        function rel = custom(obj, option, comp_type, comp_par, snorm_type, snorm_par, tnorm_type, tnorm_par)
            arguments
                obj
                option = []
                comp_type = 'basic'
                comp_par = []
                snorm_type = 'max'
                snorm_par = []
                tnorm_type = 'min'
                tnorm_par = []
            end
            switch option
                case 1 % p->q: p-not or q
                    rel = Snorm(complement_opr(obj.mux).set_type(comp_type,comp_par), obj.muy).set_type(snorm_type,snorm_par);
                case 2 % p->q: (p and q) or p-not
                    rel = Snorm(Tnorm(obj.mux,obj.muy).set_type(tnorm_type,tnorm_par),complement_opr(obj.mux).set_type(comp_type,comp_par)).set_type(snorm_type,snorm_par);
            end
        end
        

        %% Dienes-Rescher 
        function rel = Rescher(obj)
            % p-not or q
            % comp: basic
            % union: max
            rel = obj.custom(1,'basic',[],'max',[]);
        end

        %% Lukasiewicz 
        function rel = Lukasiewicz(obj)
            % p-not or q
            % comp: basic
            % union: yager, w=1
            rel = obj.custom(1,'basic',[],'yager',1);
        end

        %% Zadeh 
        function rel = Zadeh(obj)
            % (p and q) or p-not
            % comp: basic
            % union: max
            % intersection: min
            rel = obj.custom(2,'basic',[],'max',[],'min',[]);
        end

        %% Godel 
        function rel = Godel(obj)
            if obj.mux <= obj.muy
                rel = 1;
            else
                rel = obj.muy;
            end
        end

        %% mamdani 
        function rel = Mamdani(obj, type)
            arguments
                obj
                type = '*'
            end

            switch type
                case '*'
                    rel = Tnorm(obj.mux,obj.muy).alg;
                case 'min'
                    rel = Tnorm(obj.mux,obj.muy).min;
            end
        end

    end
end