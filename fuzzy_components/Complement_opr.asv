%% Fuzzy Complement Operations

% usage
%   1. Complement_opr('sugeno', 0.2, 0).value
%   2. Complement_opr.Sugeno(0.2, 0)

% v1 Nov-28-2023
% v2 Nov-29-2023

classdef Complement_opr

    properties
        value
    end

    methods
        function o = Complement_opr(type,mux,parameter)
            switch lower(type)
                case 'basic'
                    o.value = Complement_opr.basic(mux);
                case 'sugeno'
                    if nargin<3; error('Sogeno class need parameter(lambda)'); end
                    o.value = Complement_opr.Sugeno(mux,parameter);
                case 'yager'
                    if nargin<3; error('Yager class need parameter(w)'); end
                    o.value = Complement_opr.Yager(mux,parameter);
            end
        end
    end

    methods (Static)
        % common
        function comp = basic(mux)
            comp = 1 - mux;
        end

        % Sugeno class
        function comp = Sugeno(mux, lambda)
            arguments
                mux
                lambda (1,1) {mustBeGreaterThan(lambda, -1)} = 0 % (-1:inf)
            end
            comp = (1 - mux) / (1 + mux * lambda);
        end


        % Yager class
        function comp = Yager(mux, w)
            arguments
                mux
                w (1,1) {mustBeGreaterThan(w,0)} = 1 % (0:inf)
            end
            comp = (1-mux^w)^(1/w);
        end

    end
end
