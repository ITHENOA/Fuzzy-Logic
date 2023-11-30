function [n_mf] = n_mf_approx(g,maxError,U)

syms h e

n_vars = numel(symvar(sym(g)));
D = cell(2, n_vars);
% infnorm = zeros(2, n_vars);
hhh=[inf inf];
% infnorm_h = sym([0 0]);
h = sym('h',[1,n_vars]);
for d = 1:2
    infnorm_h = sym(0);
    for i = 1:n_vars
        D{d,i} = diff(g, symvar(sym(g), i));
        infnorm_h = infnorm_h + norm(subs(D{i}, symvar(sym(g), i), U(i,1):.1:U(i,2)), 'inf') * h(i)^d;
    end
    if d == 2; infnorm_h = infnorm_h * sym(1/8); end
    hh = double(solve(subs(infnorm_h==e,e,maxError)));
    hhh(d) = hh(hh>0);
end
n_mf = round(abs(U(:,2)-U(:,1))./hhh + 1);
