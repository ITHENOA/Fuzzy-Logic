%% Fuzzy Intersection - T-Norm

% usage
%   1. Tnorm('yager',a,b,w).value
%   2. Tnorm.Yager(a,b,w)

% v1 Nov-28-2023
% v2 Nov-29-2023

classdef Tnorm

    properties
        value
    end

    methods
        function o = Tnorm(type,a,b,parameter)
            switch lower(type)
                case 'min'
                    o.value = Tnorm.Min(a,b);
                case {'alg', 'algebraic'}
                    o.value = Tnorm.Algebraic(a,b);
                case 'enistein'
                    o.value = Tnorm.Enistein(a,b);
                case 'yager'
                    if nargin<4; error('Yager class need parameter(w)'); end
                    o.value = Tnorm.Yager(a,b,parameter);
                case 'dunios'
                    if nargin<4; error('Dubois-Prade class need parameter(alpha)'); end
                    o.value = Tnorm.Dunios(a,b,parameter);
                case 'dombi'
                    if nargin<4; error('Dombi class need parameter(lambda)'); end
                    o.value = Tnorm.Dombi(a,b,parameter);
                case 'drastic'
                    o.value = Tnorm.Drastic(a,b);
                otherwise
                    error('Enter correct Tnorm name.')
            end
        end
    end

    methods (Static)
        %% Minimum
        function t = Min(a,b)
            t = min(a,b);
        end

        %% Algebraic product
        function t = Algebraic(varargin)
            t = a .* b;
            % t = ones(size(varargin{1}));
            % for i = varargin
            %     t = t .* cell2mat(i);
            % end
        end

        %% Enistein product
        function t = Enistein(a,b)
            t = (a.*b)./(2-(a+b-a.*b));
        end

        %% Drastic product
        function t = Drastic(a,b)
            if b == 1
                t = a;
            elseif a == 1
                t = b;
            else
                t = 0;
            end
        end

        %% Yager class
        function t = Yager(a,b,w)
            arguments
                a
                b
                w (1,1) {mustBePositive} = 1
            end
            t = 1 - min(1,((1-a)^w + (1-b)^w)^(1/w));
        end

        %% Dubois-Prade class
        function t = Dunios(a,b,alpha)
            arguments
                a
                b
                alpha (1,1) {mustBeGreaterThanOrEqual(alpha,0), mustBeLessThanOrEqual(alpha,1)}
            end
            t = (a.*b)/max(max(a,b),alpha);
        end

        %% Dombi class
        function t = Dombi(a,b,lambda)
            arguments
                a
                b
                lambda (1,1) {mustBePositive}
            end
            t = 1/(1+((1/a - 1)^lambda + (1/b - 1)^lambda)^(1/lambda));
        end

    end

end