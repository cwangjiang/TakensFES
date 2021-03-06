%function meshless_jacobian

% This code compute the determinante of the mapping Jacobian matrix between
% the Original attractor and reconstructed one.
%
% Copyright by Jiang Wang, 2018

clear;
dim=3;
N=1990;

load('EBD.mat','-ascii');
load('Lorenz_sparse.mat');


dimProj=3;

A = EBD(:,[3,2,1]);

X = Lorenz_sparse(1:1990,[1,2,3]);
% 
% 
% load('LoRCT.mat');
% load('Lorenzs.mat');
% 
% 
% dimProj=3;
% 
% A = LoRCT(:,[1,2,3]);
% 
% X = Lorenzs(1:1990,[1,2,3]);

%A = X;

% looping over points
A_est=nan(N,dimProj);
J_est=nan(N,dimProj,dim);
for ii=1:N
    
    % selecting point
    r=X(ii,:);

    % computing arrays
    delta_r = repmat(r,N,1) - X;
    abs_delta_r = sqrt(sum(delta_r.*delta_r,2));
    [abs_delta_r_SORT,idx_SORT] = sort(abs_delta_r,'ascend');
    
    bandwidth = 2;
    s = bandwidth;
    sigma=diag(s*ones(dim,1));

    delta_r_sigma_neg2 = delta_r*sigma^(-2);
    W = exp(-0.5*sum(delta_r_sigma_neg2.*delta_r,2));
    
    NN=sum(sqrt(abs_delta_r)<s);
    min_NN=0;					% PARAMETER 2: MINIMUM # OF NEIGHBORS WITHIN GAUSSIAN BANDWIDTH RQD TO COMPUTE JACOBIAN ESTIMATION
    if (NN > min_NN)
        
        % estimating A(r)
        A_r=nan(1,dimProj);
        for pp=1:dimProj
            A_r(pp) = sum(A(:,pp).*W)/sum(W);
        end
        %A_r
        A_est(ii,:)=A_r;

        % estimating J(r)
        J_r=nan(dimProj,dim);
        Z=sum(W,1);
        for pp=1:dimProj
            J_r(pp,:) = sum(delta_r_sigma_neg2.*repmat(W,1,dim),1) * sum(A(:,pp).*W,1) / Z^2 - sum(delta_r_sigma_neg2.*repmat(A(:,pp),1,dim).*repmat(W,1,dim),1) / Z;
        end
        %J_r
        J_est(ii,:,:)=J_r;
        
    end
    
end


if dim==3
    
    figure;
    ll=1;
    for ii=1:dimProj
        subplot(dimProj,2,ll);
        scatter3(X(:,1),X(:,2),X(:,3),15,A(:,ii),'filled');
        xlabel('x'); ylabel('y'); zlabel('z');
        title(['A(',num2str(ii),')']);
        colorbar;
        caxis([min(cat(1,A(:,ii),A_est(:,ii))) max(cat(1,A(:,ii),A_est(:,ii)))]);
        ll=ll+1;
        
        subplot(dimProj,2,ll);
        scatter3(X(:,1),X(:,2),X(:,3),15,A_est(:,ii),'filled');
        xlabel('x'); ylabel('y'); zlabel('z');
        title(['A(',num2str(ii),')\_est']);
        colorbar;
        caxis([min(cat(1,A(:,ii),A_est(:,ii))) max(cat(1,A(:,ii),A_est(:,ii)))]);
        ll=ll+1;
    end
    
    figure;
    ll=1;
    for ii=1:dimProj
        for jj=1:dim
            %subplot(dimProj,2*dim,ll);
            %scatter3(X(:,1),X(:,2),X(:,3),15,J(:,ii,jj),'filled');
            %xlabel('x'); ylabel('y'); zlabel('z');
            %title(['J(',num2str(ii),',',num2str(jj),')']);
            %colorbar;
            %caxis([min(cat(1,J(:,ii,jj),J_est(:,ii,jj))) max(cat(1,J(:,ii,jj),J_est(:,ii,jj)))]);
            %ll=ll+1;
            
            subplot(dimProj,dim,ll);
            scatter3(X(:,1),X(:,2),X(:,3),15,J_est(:,ii,jj),'filled');
            xlabel('x'); ylabel('y'); zlabel('z');
            title(['J(',num2str(ii),',',num2str(jj),'\_est)']);
            colorbar;
            %caxis([min(cat(1,J(:,ii,jj),J_est(:,ii,jj))) max(cat(1,J(:,ii,jj),J_est(:,ii,jj)))]);
            ll=ll+1;
        end
    end
end


DetJ = J_est(:,1,1).*J_est(:,2,2).*J_est(:,3,3)+J_est(:,1,2).*J_est(:,2,3).*J_est(:,3,1)+J_est(:,1,3).*J_est(:,2,1).*J_est(:,3,2)-J_est(:,1,3).*J_est(:,2,2).*J_est(:,3,1)-J_est(:,1,2).*J_est(:,2,1).*J_est(:,3,3)-J_est(:,1,1).*J_est(:,2,3).*J_est(:,3,2);

figure;
scatter3(X(:,1),X(:,2),X(:,3),15,DetJ(:),'filled');
xlabel('x','fontsize',20); 
ylabel('y','fontsize',20);
zlabel('z','fontsize',20);
title(['detJ'],'fontsize',30);
colorbar;

view([1 -1 0.5]);
print(gcf,'-dpng','Lorenz_detJ.png')

%caxis([min(cat(1,J(:,ii,jj),J_est(:,ii,jj))) max(cat(1,J(:,ii,jj),J_est(:,ii,jj)))]);
            
figure;
plot(DetJ);
xlabel('time','fontsize',20); 
ylabel('detJ','fontsize',20);
print(gcf,'-dpng','detJ_1D.png')


%end