function y_pred = fuzzySystem(X_test,rules,center,MFs)
    [m,n] = size(X_test);
    y_pred = zeros(m,1);
    for j = 1:m
        prod_mf_x = ones(length(rules),1);
        prod_mf_xy = ones(length(rules),1);
        for l=1:length(rules)
            for nn = 1:n
                prod_mf_x(l,1) = prod_mf_x(l,1) * MFs{rules(l,nn),nn}(X_test(j,nn));
            end
            prod_mf_xy(l,1) = prod_mf_x(l,1) * center(rules(l,end),end);
        end
    y_pred(j) = sum(prod_mf_xy)/sum(prod_mf_x);
    end
end