%% Fuzzy Union - S-Norm

% usage
%   1. Snorm('yager',a,b,w).value
%   2. Snorm.Yager(a,b,w)

% v2 Nov-28-2023
classdef Snorm

    properties
        value
    end

    methods
        function o = Snorm(type,a,b,parameter)
            switch lower(type)
                case 'min'
                    o.value = Snorm.Max(a,b);
                case {'alg', 'algebraic'}
                    o.value = Snorm.Algebraic(a,b);
                case 'enistein'
                    o.value = Snorm.Enistein(a,b);
                case 'yager'
                    if nargin<4; error('Yager class need parameter(w)'); end
                    o.value = Snorm.Yager(a,b,parameter);
                case 'dunios'
                    if nargin<4; error('Dubois-Prade class need parameter(alpha)'); end
                    o.value = Snorm.Dunios(a,b,parameter);
                case 'dombi'
                    if nargin<4; error('Dombi class need parameter(lambda)'); end
                    o.value = Snorm.Dombi(a,b,parameter);
                case 'drastic'
                    o.value = Snorm.Drastic(a,b);
                otherwise
                    error('Enter correct Snorm name.')
            end
        end
    end

    methods (Static)

        % Maximum (basic)
        function s = Max(a,b)
            s = max(a,b);
        end

        % Algebraic sum
        function s = Algebraic(a,b)
            s = a + b - a .* b;
        end

        % Enistein sum
        function s = Enistein(a,b)
            s = (a+b)./(1+a.*b);
        end

        % Drastic sum
        function s = Drastic(a,b)
            if b == 0
                s = a;
            elseif a == 0
                s = b;
            elseif a > 0 && b > 0
                s = 1;
            end
        end

        % Yager class
        function s = Yager(a,b,w)
            arguments
                a
                b
                w (1,1) {mustBePositive} = 1
            end
            s = min(1,(a^w+b^w)^(1/w));
        end

        % Dubois-Prade class
        function s = Dunios(a,b,alpha)
            arguments
                a
                b
                alpha (1,1) {mustBeGreaterThanOrEqual(alpha,0), mustBeLessThanOrEqual(alpha,1)}
            end
            s = (a+b-a.*b-min(min(a,b),1-alpha))./(max(max(1-a,1-b),alpha));
        end

        % Dombi class
        function s = Dombi(a,b,lambda)
            arguments
                a
                b
                lambda (1,1) {mustBePositive}
            end
            s = 1/(1+((1/a - 1)^-lambda + (1/b - 1)^-lambda)^(-1/lambda));
        end

    end

end