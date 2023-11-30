%% Averaging Operators
% cover the interval between [tnorm(a,b), snorm(a,b)]

% usage
%     1. Avg_opr('max_min',a,b,lambda).value
%     2. Avg_opr.Max_min(a,b,lambda)

% v2 Nov-28-2023
% v3 Nov-29-2023

classdef Avg_opr

    properties
        value
    end

    methods
        function o = Avg_opr(type,a,b,parameter)
            switch lower(type)
                case 'max_min'
                    if nargin<3; error('max_min need parameter(lambda)'); end
                    o.value = Avg_opr.Max_min(a,b,parameter);
                case 'gen_mean'
                    if nargin<3; error('gen_mean need parameter(alpha)'); end
                    o.value = Avg_opr.Gen_mean(a,b,parameter);
                case 'fuzzy_and'
                    if nargin<3; error('fuzzy_and need parameter(p)'); end
                    o.value = Avg_opr.Fuzzy_and(a,b,parameter);
                case 'fuzzy_or'
                    if nargin<3; error('fuzzy_or need parameter(gamma)'); end
                    o.value = Avg_opr.Fuzzy_or(a,b,parameter);
                otherwise
                    error('Enter correct type name.')
            end
        end
    end

    methods (Static)

        % Max-Min
        function avg = Max_min(a,b,lambda)
            arguments
                a
                b
                lambda (1,1) {mustBeGreaterThanOrEqual(lambda,0), mustBeLessThanOrEqual(lambda,1)}
            end
            avg = lambda*max(a,b) + (1-lambda)*min(a,b);
        end

        % Generalized means
        function avg = Gen_mean(a,b,alpha)
            arguments
                a
                b
                alpha (1,1) {mustBeNonzero}
            end
            avg = ((a^alpha + b^alpha)/2)^(1/alpha);
        end

        % Fuzzy And 
        function avg = Fuzzy_and(a,b,p)
            arguments
                a
                b
                p (1,1) {mustBeGreaterThanOrEqual(p,0), mustBeLessThanOrEqual(p,1)}
            end
            avg = p*min(a,b) + (1-p)*(a+b)/2;
        end

        % Fuzzy Or
        function avg = Fuzzy_or(a,b,gamma)
            arguments
                a
                b
                gamma (1,1) {mustBeGreaterThanOrEqual(gamma,0), mustBeLessThanOrEqual(gamma,1)}
            end
            avg = gamma*max(a,b) + (1-gamma)*(a+b)/2;
        end

    end

end