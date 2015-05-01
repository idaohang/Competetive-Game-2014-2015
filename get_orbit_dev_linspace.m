function [ rho ] = get_orbit_dev_linspace(n)
    weights = [0.3 0.25 0.2 0.15 0.1];
    bounds = [0 0.4 0.8 1.2 1.6 2];
    points = floor(weights*n);
    %disp(['points ' num2str(points) ' ' num2str(sum(points))])
    rho = [];
    for i=1:length(points)
        part = linspace(bounds(i), bounds(i+1), points(i)+2);
        part = part(1:end-1);
        rho = [rho, part];
    end
    rho = [rho, bounds(end)];
end