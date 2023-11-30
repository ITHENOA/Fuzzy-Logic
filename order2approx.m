% find MFs distance (h) to granteed required accuracy (e)

% ITHENOA - Nov-26-2023

function order2approx(g,x,U,e)
% must have g formula
syms x
y = diff(g,x,2);
x = U(1):U(2);
infnorm = norm(y(x),'inf');
