function dMap(eps,n_evecs,LB_flag,X)


% This code conduct diffusion map nonlinear manifold learning. The input
% is N by n matrix, indicating N observations of n dimensional points, this
% code compute the pairwise Euclidean distance for these N points, and
% conduct diffusion maps. 
%
% Copyright by Jiang Wang, 2018

dist = squareform(pdist(X));
N = length(X);

% eps = 0.8;
% n_evecs = 20;
% LB_flag = 0;

A = exp(-dist.^2/(2*eps));
clear dist;

D = zeros(N,1);
for i=1:N
    D(i) = sum( A(i,:) );
end
D = diag(D);
D_inv = diag( diag(D).^(-1) );


if (LB_flag==0) % FP norm

    M = D_inv*A;
    clear A;
else            % LB norm

    A = D_inv*A*D_inv;
    
    D = zeros(N,1);
    for i=1:N
        D(i) = sum( A(i,:) );
    end
    D = diag(D);
    D_inv = diag( diag(D).^(-1) );
    
    M = D_inv*A;
    
end
    

[evecs,evals] = eigs(M,n_evecs);
evals = diag(evals);


% plotting eval spectrum
figure;

bar(evals);
xlim([0 n_evecs+1]);
ylim([0 1]);
xlabel('eval id ');
ylabel('eval ');

saveas(gcf,'dMap__evalSpectrum','fig');


% embedding data in top three non-trivial evecs
figure;

scatter3(evecs(:,2),evecs(:,3),evecs(:,4),15,[1:1:size(evecs,1)]','filled');
xlabel('evec2 ');
ylabel('evec3 ');
zlabel('evec4 ');
colorbar;

saveas(gcf,'dMap__evec234','fig');


% saving results
save dMap.mat evals evecs
end

