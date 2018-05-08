%function RCT
 
D = input('Enter the dimension of embeding space:'); %determin dimension of embeding space
T = input('Enter the delay time T:');%input delay time


load dist120_stride1.mat;
%load X;
O = dist120(1:1000000);
O = O/std(O);
skip = 10;

len = length(O);%real length, # of snapshots
L = len-(D-1)*T;%effective length

%fprintf('The original number of snapshots is %d, the unmber of reconstructed points is %d\n',len, L);%show change of # of data points


EBD = zeros(round(L/skip),D);%D dimensional embeding space
Index = 1:skip:L;
for i = 1:round(L/skip)%scan over first # of L points
    if(mod(i,1001) == 0)
        fprintf('%d \n',i);
    end
    
%     for  j = 1:D%scan over D components of each point
%          EBD(i,j) = O(i+(j-1)*T);
%     end
    ii = Index(i);
    select = ii:T:(ii+(D-1)*T);
    EBD(i,:) = O(select);
end

save('EBD.mat','EBD','-ascii');


%O = h2t;
% O = O/std(O);
% for i = 1:L%scan over first # of L points
%     for  j = (D+1):(2*D)%scan over D components of each point
%          EBD(i,j) = O(i+(j-1)*T);
%     end
% end



%EBD = cat(1,EBD, fliplr(EBD));

%EBDflip = fliplr(EBD);

%mindist = squareform(min(pdist2(EBD,EBD),pdist2(EBD,EBDflip)));


%PD = pdist(EBD);%calculate pairwise Euclidian distance into a lower traingular matix but in a 1-d vector form.
%PD_ovlp= pdist(EBD_ovlp);
%PD = pdist(EBD,'chebychev');%use other way to calculat distance.

%DIST = squareform(PD);
%DIST1 = squareform(PD_ovlp);
%DIST = zeros(L*L,1);%whole L by L distance matrix in a 1-d vector form
%for i = 1:L%sanc over # of rows
%    for j = 1:L%scan over of of column for each row
%        if j ~= i%skip diagonal unit, keep it to be 0.
%            DIST((i-1)*L+j) = PD(max(i,j)-min(i,j) + (2*L-min(i,j))*(min(i,j)-1)/2);%construct full 1-d distance matrix from 1-d vector of lower half dist matrix pdist 
%        end
%    end
%end

%A = zeros(6,L);%A is matrix convinient for import Xi sequences
%for q = 1:3% first three row are average Xi_q
%    for i = 1:L% scan over L reconstructed points
%        for j = 1:D% scan over D component, for doing summation
%            A(q,i) = A(q,i) + M1(q+3,i + (j-1)*T);            
%        end
%        A(q,i) = A(q,i)/D;% take average
%    end
%end
%for q = 4:6% last three row are original Xi
%    for i = 1:L
%         A(q,i) = M1(q,i);    
%    end
%end
%R = reshape(DIST,[9937^2,1]);

%save('DIST.mat','DIST');
%save('DIST_h2t_helixRMSD.mat','DIST');
 
%ma = max(max(DIST));
%mi = min(min(DIST));

%fid1 = fopen('distances.dat','wt');%open human readable .dat file
%fprintf(fid1,'%f\n',DIST);%write to readable file in a 1-d vector form.
%fclose(fid1);

%fid2 = fopen('distances.bin','wb');%open binary .bin file
%fwrite(fid2,DIST','float');%import with transposition of DIST
%fclose(fid2);

%fid3 = fopen('datas.txt','wt');%this file is to give some imformation so that it's easy to do future study
%fprintf(fid3,'There are %d points in embedding space with embedding dimension %d, delay time %d.\nThe maximun distance is %f.\nThe minimum distance is %f',L,D,T,ma,mi);
%fclose(fid3);
    
%fid4 = fopen('Xi.dat','wt');%open Xi sequences file
%fprintf(fid4,'The colums are average \n averged         original \nxi_1 xi_2 xi_3 xi_1 xi_2 xi_3\n');%description to the columns
%fprintf(fid4,'%f %f %f %f %f %f\n',A);%average and original Xi_i as a 6 column file.
%fclose(fid4);

%end

