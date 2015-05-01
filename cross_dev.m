function [ tt_new ] = cross_dev( tt, avg, tol )

if(nargin < 3 || isempty(tol))
    tol = 1e-9;
end

inp = size(tt);


fun = @(ind) tt(ind) - avg;

tt_new = amen_cross(inp, fun, tol);

end

