function tt_coords = main(n, tol)
global rho
global phi
global delta_dev
global S
global delta
global count
count = 0;

tic

if(nargin < 2 || isempty(tol))
    tol = 1e-6;
end
if(nargin < 1 || isempty(n))
    n = 0;
end 
data = load('mathgame_data.mat');
S = data.S;
delta = data.delta;

rho = get_orbit_dev_linspace(n);
phi = get_orbit_dev_angle_linspace(n);
delta_dev = get_pseudo_dist_dev_linspace(n);
inp = [length(rho)*ones(1,5) length(phi)*ones(1,5) length(delta)*ones(1,5)];
% disp(S)
tt_coords = amen_cross(inp, @solve, tol);
toc

tt_save('tt_coords', tt_coords);
% toc
end

function coords = solve(ind)
    global rho
    global phi
    global delta_dev
    global delta
    global S
    global count
    fprintf('%d\r', count);
    count = count + 1;
    rho_ind = ind(1:5);
    phi_ind = ind(6:10);
    delta_ind = ind(11:15);
    coords = solve_lateration(S, rho(rho_ind), phi(phi_ind), delta + delta_dev(delta_ind), 10^6);
end

