function area = test(length, width, varargin)
% CALCULATEAREA calculates the area of a rectangle.
%
%   AREA = CALCULATEAREA(LENGTH, WIDTH) calculates the area of a rectangle
%   with the specified length and width.
%
%   AREA = CALCULATEAREA(LENGTH, WIDTH, 'Unit', 'square meters', 'Display', true)
%   calculates the area with additional options.
%
%   Optional Parameters:
%      'Unit'    - String specifying the unit of the area (default: 'square units').
%      'Display' - Logical specifying whether to display the result (default: false).
%
%   Example:
%      area = calculateArea(5, 8, 'Unit', 'square feet', 'Display', true);
%
%   See also: fprintf

% Input parsing
p = inputParser;
p.addParameter('Unit', 'square units', @(x) ischar(x));
p.addParameter('Display', false, @(x) islogical(x));

% Parse inputs
parse(p, varargin{:});

% Calculate area
area = length * width;

% Display result if specified
if p.Results.Display
    fprintf('The area is %.2f %s.\n', area, p.Results.Unit);
end

end
