function [ tt ] = cross_minus( tt1, tt2, tol )

if(nargin < 3 || isempty(tol))
    tol = 1e-9;
end

fun = @(x) x(:, 1) - x(:, 2);

tt = amen_cross({tt1,tt2}, fun, tol);

end

