classdef Gauss 

    properties
        c
        sig
    end

    methods
        function obj = Gauss(c,sig)
            obj.c = c;
            obj.sig = sig;
        end

        function m = set(obj,x)
            m = exp(-((x-obj.c)/obj.sig).^2);
        end
    end
end