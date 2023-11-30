function p = projection(z,axis)
% z: matrix
% axis: 'x' or 'y'
    try
        [m,n] = size(z);
        if strcmpi(axis,'x')

            p = z;
            [maximum, index]=max(z);
            
            for i=1:m
	            for j=1:n
		            if i < index(j)
			            p(i,j) = maximum(j);
		            end
	            end
            end

        elseif strcmpi(axis,'y')

            p = z;
            [maximum, index]=max(z');
            for i=1:m
	            for j=1:n
		            if j < index(i)
		            	p(i,j) = maximum(i);
	        	    end
	            end
            end

        end

    catch
        disp('Projection Error')
    end
end