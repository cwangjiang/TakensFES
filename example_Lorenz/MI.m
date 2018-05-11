function MI(O)

% This function is to compute the mutual information (MI) as a function of
% the delay time.
% 
% Refer to publication: DOI:https://doi.org/10.1103/PhysRevA.33.1134
%
% Copyright by Jiang Wang, 2018/05/10


len = length(O);

ma = max(O);
mi = min(O);
Delt = ma-mi;%gap between max and min, will be use later
fprintf('Finishing importing data, there are %d snapshots.\nthe maximun value is %d, and the minimum values is %d \n',len,ma,mi);%print out the total number of snapshots, and the max/min.

B = input('Enter the number of bins you want make:');%determin bin number
T = input('Enter the largest tao you want to test from 0:');%determin largest tao

I = zeros(T+1,1); %Mutual Information

for t=0:T
    Pt = zeros(B,1);%x(t)'s probabilistic distribution among B bins
    Ptt = zeros(B,1);%x(t+tao)'s probabilistic distribution among B bins
    Pxy = zeros(B,B);%combination probabilistic distribution among B^2 bins
    
    
    for i=1:len-t%effective number, because there are delay time T
           
          temp1 = floor((O(i)-mi)/Delt*B)+1;%this will automatically direct O(i) to its bin
          if O(i) == ma%for maximun one, there will not be more bin for it
              temp1 = temp1-1;
          end;
          Pt(temp1) = Pt(temp1)+1;%add one point into this bin
        
          
          temp2 = floor((O(i+t)-mi)/Delt*B)+1;
          if O(i+t) == ma
              temp2 = temp2-1;
          end;
          Ptt(temp2) = Ptt(temp2)+1;
        
          Pxy(temp1,temp2) = Pxy(temp1,temp2)+1;%add one point into this 2-d bin
    end
    PT = Pt/(len-t);%transfer bin counting distribution to probabilistic distribution
    PTT = Ptt/(len-t);
    PXY = Pxy/(len-t);
    
    for i = 1:B%sum over number of bins
        for j = 1:B
            if (PXY(i,j)~= 0 && PT(i)~=0 && PTT(j)~= 0)%if any P is 0, total thing is 0, can be skipped.
               I(t+1) = I(t+1) + PXY(i,j)*log2(PXY(i,j)/PT(i)/PTT(j));
            end;                     
        end
    end
    
    %fprintf('%d \n',I(t+1));%can print out files
    
end


plot(I);
xlabel('time','fontsize',20);
ylabel('MI','fontsize',20);
set(gca,'fontsize',10);
print(gcf,'-dpng','MI.png')

end

