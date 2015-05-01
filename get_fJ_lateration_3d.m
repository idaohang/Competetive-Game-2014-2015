% S - satellite pos matrix (Each j'th column is radius-vector of j'th satellite )
function [ f, J ] = get_fJ_lateration_3d_2(S, rho, phi, delta, x)
    sz = size(S);
    n = 3;
    m = 5;
    if length(x) ~= n || sz(2) ~= m || length(rho) ~= m || length(phi) ~= m || length(delta) ~= m
        throw RuntimeException("Invalid dimensions of arguments");
    end
    
    R_sqr = sum( (diag(x)*ones(n,m) - S).^2, 1);
    R = sqrt(R_sqr);
    rho_sqr = rho.^2;
    
    xm = S(1:n,m)';
    ct = delta(m) - sqrt( R_sqr(m) + rho_sqr(m) -2*R(m)*rho(m)*cos(phi(m)) );
    ct_der = - ones(m-1,n)*diag(x - xm)*( 1-rho(m)*cos(phi(m))/R(m) )/sqrt( R_sqr(m) + rho_sqr(m) - 2*R(m)*rho(m)*cos(phi(m)) );
    
    
    rho = rho(1:m-1);
    phi = phi(1:m-1);
    delta = delta(1:m-1);
    R = R(1:m-1);
    R_sqr = R_sqr(1:m-1);
    rho_sqr = rho_sqr(1:m-1);
    S = S(1:end, 1:m-1);
    m = m-1;
    
    
    f = sqrt( R_sqr + rho_sqr - 2*R.*rho.*cos(phi) ) - delta + ct*ones(1,m);
    
%     disp(['ct = ' num2str(ct) ]);
%     disp(['f = ' num2str(f)]);
%     disp(['rho = ' num2str(rho)]);
%     
%     throw RuntimeException
    
    
    J = ( ones(m,n)*diag(x) - S');
    J = J.*(diag( (ones(1,m) - rho.*cos(phi)./R)./sqrt(R_sqr + rho_sqr - 2*R.*rho.*cos(phi)) )*ones(m,n));
    J = J + ct_der;
    
%     disp(['Condition number: ' num2str(cond(J'*J))])
end

