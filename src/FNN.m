function FNN(O)

% This function is to compute the E1 measurement in FNN algorithm to
% identify the optima delay dimension.
% 
% Refer to publication: https://doi.org/10.1016/S0167-2789(97)00118-8
%
% Copyright by Jiang Wang, 2018

close all;

D = input('Enter the largest dimenstion D you want test:');%determin range of testing dimension 
T = input('Enter the delay time T:');%input delay time

len = length(O);

for m = 1:D%plot range
    fprintf('d=%f\n',m);
    [e,es] = E(m);%pick out E(d),E*(d)
    [e1,es1] = E(m+1);%pick out E(d+1),E*(d+1)
    E1(m) = e1/e;%E1(d),E1 is actually increasing it's dimension as m increasing
    E2(m) = es1/es;%E2(d)
end


%fid1 = fopen('E1.dat','wt'); 
%fprintf(fid1,'%f\n',E1); 
%fclose(fid1);


%fid2 = fopen('E2.dat','wt'); 
%fprintf(fid2,'%f\n',E2); 
%fclose(fid2);

plot(E1,'-square');
%hold on;
%plot(E2);
xlabel('Dimension','fontsize',20);
ylabel('E1','fontsize',20);
set(gca,'fontsize',10);
print(gcf,'-r100','-dpng','FNN.png');



function [ a,b ] = a( i,d )%define inner function a
    
mi = Inf;%preset the minimum norm for nearest neighbor

for j = 1:len-d*T%scan over all snapshot to caculate norm with i
    ma = 0;%preset the maximum component to be 0
    for k = 0:d-1%scan over all d components
        if abs(O(j+k*T)-O(i+k*T))>ma%select the real maximum component
            ma = abs(O(j+k*T)-O(i+k*T));
        end
    end
    if ma ~= 0%if norm is 0, means it is itself i=j, or two reconstructed vector are the same, skip
        if ma < mi%find the real minimum norm, determine the nearest neighbor
            mi = ma;
            J = j;%pick out # of nearest neighbor of i
        end
    end
end

a = max(mi,abs(O(i+d*T)-O(J+d*T)))/mi;%out put new norm in d+1 dimension for this nearest pair
b = abs(O(i+d*T)-O(J+d*T));%out put the subtraction of new component of this nearest pair   

end

  
function [E,Es] = E (d)%define the function for doing summation and average
    
   temp1 = 0;%temp for E
   temp2 = 0;%temp for E*
   
   for l = 1:len-d*T%sum over this range
       [p,q] = a(l,d);%pick out two value from function a
       temp1 = temp1 + p;%make sum
       temp2 = temp2 + q;       
   end
   
   temp1 = temp1/(len-d*T);%average
   temp2 = temp2/(len-d*T);
   
   E = temp1;%out put E
   Es = temp2;%out put E*
        
end


end


       
       


