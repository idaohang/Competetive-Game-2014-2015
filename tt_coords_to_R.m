function [ tt_R ] = tt_coords_to_R( tt_coords, tol )

if(nargin < 2 || isempty(tol))
    tol = 1e-9;
end

cores = core2cell(tt_coords);
tt_x = cell2core(tt_tensor(), tt_core_leave_axis(cores, 1));
tt_y = cell2core(tt_tensor(), tt_core_leave_axis(cores, 2));
tt_z = cell2core(tt_tensor(), tt_core_leave_axis(cores, 3));

fun = @(x) x(:, 1).^2 + x(:, 2).^2 + x(:, 3).^2;

tt_R = amen_cross({tt_x,tt_y,tt_z}, fun, tol);

end

