classdef psudoTrapMF

    properties
        sigma
    end

    methods (Static)
    
        function mf = trap(x,a,b,c,d,H)
            if nargin<6; H=1; end
            mf = psudoTrapMF.getY("trap",x,a,b,c,d,H);
        end

        function mf = tri(x,a,b,c,H)
            if nargin<5; H=1; end
            mf = psudoTrapMF.getY("tri",x,a,b,b,c,H);
        end

        % function mf = gauss(x,c,sigma,H)
        %     if nargin<4; H=1; end
        %     obj.sigma = sigma;
        %     mf = psudoTrapMF.getY("gauss",x,inf,c,c,inf,H);??
        % end
    end

    methods (Static,Access=private)

        % I
        function result = I(type,x,a,b)
            if type == "tri" || type == "trap"
                result = (x-a)/(b-a);
            elseif type == "gauss"
                % xbar = a;
                % sigma = b;
                result = exp(-((x-xbar)-obj.sigma)^2);
            end
        end

        % D
        function result = D(type,x,c,d)
            if type == "tri" || type == "trap"
                result = (x-d)/(c-d);
            elseif type == "gauss"
                result = psudoTrapMF.I("gauss",c,d);
            end
        end
        
        % get_y
        function y = getY(type,x,a,b,c,d,H)
            i=1;
            y = zeros(size(x));
            for x = x
                if x>=a && x<b
                    y(i) = psudoTrapMF.I(type,x,a,b);
                elseif x>=b && x<=c
                    y(i) = H;
                elseif x>c && x<=d
                    y(i) = psudoTrapMF.D(type,x,c,d);
                else
                    y(i) = 0;
                end
                i=i+1;
            end
        end

    end

end