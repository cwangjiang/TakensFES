function [X,T] = lorenz_generating(rho, sigma, beta, initV, T, eps)
% LORENZ Function generates the lorenz attractor of the prescribed values
% of parameters rho, sigma, beta
%
%   [X] = LORENZ(RHO,SIGMA,BETA,INITV,T,EPS)
%       X - output vectors of the strange attactor trajectories
%       RHO     - Rayleigh number
%       SIGMA   - Prandtl number
%       BETA    - parameter
%       INITV   - initial point
%       T       - time interval
%       EPS     - ode solver precision
%
% Example.
%        [X] = lorenz(28, 10, 8/3);
%        plot3(X,Y,Z);

if nargin<3
  error('MATLAB:lorenz:NotEnoughInputs','Not enough input arguments.'); 
end

if nargin<4
  eps = 0.000001;
  T = [0 100];
  initV = [0 1 1.05];
end

options = odeset('RelTol',eps,'AbsTol',[eps eps eps/10]);
[T,X] = ode45(@(T,X) F(T, X, sigma, rho, beta), T, initV, options);

X(:,1) = (X(:,1)-mean(X(:,1)))/std(X(:,1));
X(:,2) = (X(:,2)-mean(X(:,2)))/std(X(:,2));
X(:,3) = (X(:,3)-mean(X(:,3)))/std(X(:,3));

plot3(X(:,1),X(:,2),X(:,3));
axis equal;
grid;
title('Lorenz attractor');
xlabel('X'); ylabel('Y'); zlabel('Z');

Lorenz_full = X;
save Lorenz_full.mat Lorenz_full;

return

end

function dx = F(T, X, sigma, rho, beta)
% Evaluates the right hand side of the Lorenz system
% x' = sigma*(y-x)
% y' = x*(rho - z) - y
% z' = x*y - beta*z
% typical values: rho = 28; sigma = 10; beta = 8/3;

    dx = zeros(3,1);
    dx(1) = sigma*(X(2) - X(1));
    dx(2) = X(1)*(rho - X(3)) - X(2);
    dx(3) = X(1)*X(2) - beta*X(3);
    return
end