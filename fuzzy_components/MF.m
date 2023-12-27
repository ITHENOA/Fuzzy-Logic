%% Membership Function

% param = [a,b,c,d]
% Gaussian --> param = [c sigma]
% Triangle --> param = [a b c]
% Generalized Bell --> param = [a b c]
% Trapzoidal --> param = [a b c d]
% sigmoidal --> param = [a c]
% Left-Right --> param = [c alpha beta]

% usage
%   1. MF('gauss',c,sigma).membership(x)
%   2. MF.Gaussian(c,sigma).membership(x)



% v1: Nov-25-2023
% v2: Nov-29-2023

classdef MF

    properties
        type
        par
    end

    methods

        function o = MF(type, varargin)
            o.type = lower(type);
            o.par = varargin;                
        end

        function m = membership(o,x)
            switch o.type
                case {'gaussian', 'gauss'}
                    c = o.par{1};
                    sigma = o.par{2};
                    m = exp( - ((x - c) / sigma) .^ 2);
                case {'triangular', 'tri'}
                    a = o.par{1};
                    b = o.par{2};
                    c = o.par{3};
                    m = max(min( ( x - a) / (b - a) , (c - x) / (c - b)) ,0 );
                case 'gbell'
                    a = o.par{1};
                    b = o.par{2};
                    c = o.par{3};
                    m = 1 / (1 + abs((x - c) / a) .^ (2 * b));
                case {'sigmoidal', 'sig'}
                    a = o.par{1};
                    c = o.par{2};
                    m = 1 / 1 + exp(- a * (x - c));
                case {'trapzoidal', 'trap'}
                    a = o.par{1};
                    b = o.par{2};
                    c = o.par{3};
                    d = o.par{4};
                    m = max(min(min((x - a) / (b - a), 1), (d - x) / (d - c)), 0);
                case 'lr'
                    c = o.par{1};
                    alpha = o.par{2};
                    beta = o.par{3};
                    if x >= c
                        m = max(0, sqrt(1 - ((c - x) / alpha) ^ 2));
                    else
                        m = exp(- abs((x - c) / beta) ^ 3);
                    end
                otherwise
                    error("Enter correct MF type: {'gaussian','triangular','gbell','sigmoidal','trapzoidal','lr'}")
            end
        end
    end

    %%
    methods (Static)
        % Gaussian
        function mf = Gaussian(c,sigma)
            mf = MF('Gaussian',c,sigma);
        end

        % Triangular
        function mf = Triangular(a,b,c)
            if nargin == 1
                if numel(a) == 3
                    c = a(3);
                    b = a(2);
                    a = a(1);
                else
                    error('Enter Correct Inputs: (a,b,c) or ([a,b,c])')
                end
            end
            mf = MF('Triangular',a,b,c);
        end

        % Gbell
        function mf = Gbell(a,b,c)
            mf = MF('Gbell',a,b,c);
        end

        % Sigmoidal
        function mf = Sigmoidal(a,c)
            mf = MF('Sigmoidal',a,c);
        end

        % Trapzoidal
        function mf = Trapzoidal(a,b,c,d)
            mf = MF('Trapzoidal',a,b,c,d);
        end
        
        % LR
        function mf = LR(c,alpha,beta)
            mf = MF('LR',c,alpha,beta);
        end
    end
end