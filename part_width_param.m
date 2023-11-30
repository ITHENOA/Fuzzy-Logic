% v1 - ITHENOA - Nov-25-2023

classdef part_width_param

    methods (Static)

        function [a,b,c,d] = tri(cutpoints)
            n_mf = numel(cutpoints)-1;
            [a,b,c,d] = deal(zeros(1,n_mf));
            for part = 1:n_mf
                prtBound = [cutpoints(part), cutpoints(part+1)];
                mean = (prtBound(1) + prtBound(2))/2;
                tmean = (prtBound(2) - prtBound(1))/2;
                if part == 1
                    a(part) = prtBound(1);
                    b(part) = prtBound(1);
                    c(part) = mean;
                    d(part) = prtBound(2) + tmean;
                elseif part == n_mf
                    a(part) = prtBound(1)-tmean;
                    b(part) = mean;
                    c(part) = prtBound(2);
                    d(part) = prtBound(2);
                else
                    a(part) = prtBound(1)-tmean;
                    b(part) = mean;
                    c(part) = mean; % trisngular: b=c
                    d(part) = prtBound(2)+tmean;
                end
            end
        end

        function [a,b,c,d] = trap(cutpoints)
            n_mf = numel(cutpoints)-1;
            [a,b,c,d] = deal(zeros(1,n_mf));
            for part = 1:n_mf
                prtBound = [cutpoints(part), cutpoints(part+1)];
                minus3 = (prtBound(2) - prtBound(1))/3;
                minus4 = (prtBound(2) - prtBound(1))/4;
                if part == 1
                    a(part) = prtBound(1);
                    b(part) = prtBound(1);
                    c(part) = prtBound(2) - minus3;
                    d(part) = prtBound(2) + minus3;
                elseif part == n_mf
                    a(part) = prtBound(1)-minus3;
                    b(part) = prtBound(1)+minus3;
                    c(part) = prtBound(2);
                    d(part) = prtBound(2);
                else
                    a(part) = prtBound(1)-minus4;
                    b(part) = prtBound(1)+minus4;
                    c(part) = prtBound(2)-minus4;
                    d(part) = prtBound(2)+minus4;
                end
            end
        end

        function [cl,sigl,cr,sigr] = gauss(cutpoints)
            n_mf = numel(cutpoints)-1;
            [cl,cr,sigl,sigr] = deal(zeros(1,n_mf));
            for part = 1:n_mf
                prtBound = [cutpoints(part), cutpoints(part+1)];
                mean = (prtBound(1) + prtBound(2))/2;
                minus = (prtBound(2) - prtBound(1))/2/sqrt(log(4));
                if part == 1
                    cl(part) = prtBound(1);
                    sigl(part) = 1;
                    cr(part) = mean;
                    sigr(part) = minus;
                elseif part == n_mf
                    cl(part) = mean;
                    sigl(part) = minus;
                    cr(part) = prtBound(2);
                    sigr(part) = 1;
                else
                    cl(part) = mean;
                    sigl(part) = minus;
                    cr(part) = mean;
                    sigr(part) = minus;
                end
            end
        end

    end
end

