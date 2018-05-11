load dMap.mat;

N = length(evecs);

scatter(evecs(:,2),evecs(:,3),20,1:N,'filled');

xlabel('\psi_2','fontsize',30);
ylabel('\psi_3','fontsize',30);
set(gca,'fontsize',20);
colorbar;
print(gcf,'-r100','-dpng','Lorenz_dmap.png');

bar(evals);
xlabel('eigenvalue index','fontsize',30);
ylabel('eigenvalues','fontsize',30);
set(gca,'fontsize',20);
ylim([0 1]);
xlim([0 20]);
print(gcf,'-r100','-dpng','Lorenz_spectrum.png');