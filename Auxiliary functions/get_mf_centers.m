function centers = get_mf_centers(U,n_mf,type)
% INPUT
    % U : dimension boundaries [bound(x1);bound(x2);...;bound(xn);bound(y)] : bound(x) = [lb,ub]
    % n_mf : number of membership function in each dimension [N1,N2,...,Nn,Ny]
    % type : type of discritization
% OUTPUT
    % centers : center of membership functions for each dimension (cell array {})
switch type
    case 'equal'
        n = numel(n_mf);
        centers = cell(1,n);
        for i = 1:n
            centers{i} = linspace(U(i,1),U(i,2),n_mf(i));
        end
    otherwise
        error('Enter valid type')
end