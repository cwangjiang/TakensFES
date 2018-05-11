function RCT(O)

% This code conduct delay embedding, given a time series O, delay time tau and
% delay dimension D, it create a D dimensional vectors EBD, and a pairwise
% distance matrix of the delayed points.
%
% Copyright by Jiang Wang, 2018

D = input('Enter the dimension of embeding space:'); %determin dimension of embeding space
T = input('Enter the delay time T:');%input delay time


len = length(O);%real length, # of snapshots
L = len-(D-1)*T;%effective length


fprintf('The original number of snapshots is %d, the unmber of reconstructed points is %d\n',len, L);%show change of # of data points


EBD = zeros(L,D);%D dimensional embeding space
for i = 1:L%scan over first # of L points
    for  j = 1:D%scan over D components of each point
         EBD(i,j) = O(i+(j-1)*T);
    end
end

%PD = squareform(pdist(EBD));%calculate pairwise Euclidian distance into a lower traingular matix but in a 1-d vector form.

save('EBD.mat','EBD','-ascii');
%save('PD.mat','PD','-ascii');

plot3(EBD(:,1),EBD(:,2),EBD(:,3));
view([8 -3 3]);
xlabel('x(t-2\tau)','fontsize',20);
ylabel('x(t-\tau)','fontsize',20);
zlabel('x(t)','fontsize',20);
set(gca,'fontsize',10);
title('Delayed Lorenz attractor','fontsize',30);
axis equal;
grid on;
print(gcf,'-dpng','Lorenz_delayed.png')
 
end

