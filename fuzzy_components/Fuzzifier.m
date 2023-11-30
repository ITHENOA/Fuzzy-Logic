%% Fuzzifier

% usage
%   1. Fuzzifier(U).get_all(x, gauss_sigma, tri_a, tri_c)
%   2. Fuzzifier(U).Singleton(x)
%           >> fuzfiObj = Fuzzifier(U);
%           >> fuzfiObj.Singleton(x)
%           >> fuzfiObj.Gaussian(x)
%           >> fuzfiObj.get_all(x, gauss_sigma, tri_a, tri_c)
%
%   3. Fuzzifier(U,'single').set(x)
%           >> singObj = Fuzzifier(U,'single');
%           >> singOnj.set(x1)
%           >> singOnj.set(x2)
%
%   4. Fuzzifier(U,'single',4).value

% v1 Nov-29-2023
% Nov-30-2023 +(get_all)

classdef Fuzzifier
    properties
        value
        type
        U
        singleton
        gaussian
        triangular
    end

    methods

        % Constructor Function
        function o = Fuzzifier(U,type,x,varargin)
            o.U = U;
            if nargin == 2
                o.type = type;
            elseif nargin >= 3
                switch lower(type)
                    case {'singleton', 'single'}
                        o.value = Singleton(o,x);
                    case {'gaussian', 'gauss'}
                        if nargin<4; error('Gaussian need parameter(sigma)'); end
                        o.value = Gaussian(o,x,varargin{1});
                    case {'triangular', 'tri'}
                        if nargin<4; error('Triangular need parameter(a and c)'); end
                        o.value = Triangular(o,x,varargin{1:2});
                    otherwise
                        error('Enter correct type name')
                end
            end
        end

        %% (for two input: Fuzzifier(U,type))

        % set specific x 
        function f = set(o,x,parameter)
            switch lower(o.type)
                case {'singleton', 'single'}
                    f = Singleton(o,x);
                case {'gaussian', 'gauss'}
                    if nargin<3; error('Gaussian need parameter(sigma)'); end
                    f = Gaussian(o,x,parameter);
                case {'triangular', 'tri'}
                    if nargin<3; error('Triangular need parameter(a and c)'); end
                    f = Triangular(o,x);
                otherwise
                    error('Enter correct type name')
            end
        end

        %% (for one input: Fuzzifier(U))

        % Get all fuzzifier 
        function o = get_all(o,x,gauss_sigma,tri_a,tri_c)
            o.singleton = Singleton(o,x);
            o.gaussian = Gaussian(o,x,gauss_sigma);
            o.triangular = Triangular(o,x,tri_a,tri_c);
        end

        function f = Singleton(o,x)
            f = zeros(size(o.U));
            f(o.U == x) = 1;
        end

        function f = Gaussian(o,x,sigma)
            f = MF.Gaussian(x,sigma).membership(o.U);
        end

        function f = Triangular(o,x,a,c)
            f = MF.Triangular(a,x,c).membership(o.U);
        end
    end

end