function [pos] = solve_lateration(S, rho, phi, delta, scale)
    sz = size(S);
    n = 4;
    dims = n - 1;
    m = 5;
    if sz(2) ~= m || length(rho) ~= m || length(phi) ~= m || length(delta) ~= m
        throw RuntimeException("Invalid dimensions of arguments");
    end
    
    if ~exist('scale','var')
        scale=1.;
    end
    
    R_earth = 6371000./scale; %Earth radius
    c = 299792458./scale; %Speed of light
    tau = 1e-3;    %Let assume for initial guess desync is about millisecond
    
    rho = rho/scale;
    delta = delta/scale;
    S = S/scale;
    
    tol_f = 1e-12; 
    tol_x = 1e-12;
    %tol_x = 1e-3/scale;
    
    x0 = sum(S, 2)'/m;
    x0 = x0/norm(x0)*R_earth;
%     ct0 = c*tau;
    ct0 = 0;
    
   % x0 = zeros(1,n-1);
    %ct0 = 0;
    
%     disp('Initial guess:')
%     disp([x0 ct0])
    
    fun = @(x) get_fJ_lateration_3d(S, rho, phi, delta, x);
%    lb = zeros(1,n);
%    ub = zeros(1,n);
%    lb(1:dims) = -2*R_earth*ones(1,dims);
%    lb(n) = -Inf;
%    ub(1:dims) = 2*R_earth*ones(1,dims);
%    ub(n) = Inf;
    lb = -2*R_earth*ones(1,dims);
    ub = 2*R_earth*ones(1,dims);
    
    options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective');
    options = optimoptions(options, 'Jacobian', 'on');
    options = optimoptions(options, 'TolFun', tol_f);
    options = optimoptions(options, 'TolX', tol_x);
    options = optimoptions(options, 'display', 'off');
    
    [res, resnorm, residual, exitflag, output] = lsqnonlin(fun,x0,lb,ub,options);
   % [res, resnorm, residual, exitflag, output] = lsqnonlin(fun,[x0, ct0],lb,ub,options);
    pos = res(1:dims);
%     disp(['Position: ' num2str(res)]);
%     disp(['Radius-vector length: ' num2str(norm(pos)) ' ' num2str(scale) 'x m.'])
%     disp(['Resnorm: ' num2str(resnorm)]);
%     disp(['Exitflag: ' num2str(exitflag)]);
%     disp(['Iterations: ' num2str(output.iterations)]);
%     disp(['Message: ' output.message]);
    pos = pos*scale;
end