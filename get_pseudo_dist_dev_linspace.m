function [ delta_dev ] = get_pseudo_dist_dev_linspace(n)
    weights = [0.05 0.075 0.1 0.125 0.15 0.15 0.125 0.1 0.075 0.05];
    bounds = [-10 -8 -6 -4 -2 0 2 4 6 8 10];
    points = floor(weights*n);
    %disp(['points ' num2str(points) ' ' num2str(sum(points))])
    delta_dev = [];
    for i=1:length(points)
        part = linspace(bounds(i), bounds(i+1), points(i)+2);
        part = part(1:end-1);
        delta_dev = [delta_dev, part];
    end
    delta_dev = [delta_dev, bounds(end)];
end

