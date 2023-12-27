% generate parameters systematiclly by distance
% for 'gauss' mf : sigma == distance
% for 'tri' mf : a == b-distance, c == b+distance
% for 'gbell' mf :
% for 'sig' mf :
% for 'trap' mf :
% for 'lr' mf :
function par = get_systematic_par(mf_type,centers,distance)
%   INPUT
% centers (n_data,dim):
% distance (1,dim): distance for each dimension
%
%   OUTPUT
% par {1,dim}(n_data,n_par)

dim = size(centers,2);
n_data = size(centers,1);
par = cell(1,dim);
if numel(distance) == 1
    distance = ones(1,dim) * distance;
end

switch lower(mf_type)

    case {'tri','triangular'}
        for d = 1:dim
            for j = 1:n_data
                par{d}(j,:) = [centers(j,d)-distance(d) centers(j,d) centers(j,d)+distance(d)];
            end
        end

    case {'gauss','gaussian'}
        for d = 1:dim
            for j = 1:n_data
                par{d}(j,:) = [centers(j,d) distance(d)];
            end
        end

    case 'gbell'

    case {'sigmoidal', 'sig'}

    case {'trapzoidal', 'trap'}

    case 'lr'
end