load Lorenz_full.mat;

n = 2000;
N = length(Lorenz_full);
dt = floor(N/n);

Lorenz_sparse = zeros(n,3);


for i = 1:n
    Lorenz_sparse(i,:) = Lorenz_full(1+(i-1)*dt,:);
end

 
plot3(Lorenz_full(:,1),Lorenz_full(:,2),Lorenz_full(:,3));
axis equal;
grid on;
title('Lorenz attractor','fontsize',30);
xlabel('X','fontsize',20); ylabel('Y','fontsize',20); zlabel('Z','fontsize',20);

hold on;

scatter3(Lorenz_sparse(:,1),Lorenz_sparse(:,2),Lorenz_sparse(:,3),'r');

view([1 -1 0.5]);
print(gcf,'-dpng','Lorenz.png');

save Lorenz_sparse.mat Lorenz_sparse;
