% find nearest numbmer in your resulotion

function [nearX, idx] = findInRes(U,x)
% U: ex: 0:.1:10
% x: ex: 5.01 (is'nt in orginal resulotion)

[~,idx] = min(abs(x-U));
nearX = U(idx);