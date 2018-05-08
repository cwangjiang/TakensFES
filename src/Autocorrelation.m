function Autocorrelation

T = input('Enter the maximum delay time T:');%input maximum delay time

%V = input('Enter Scarlar function (h2t:2; Xi:3; Xi_1:4; Xi_2:5; Xi_3:6):');%choose which scalar function to use
V = 2;%automatically choose h2t

fprintf('\n')
%filename  = input('Enter filename of scalar data (formatted as polystat.dat): ');%type in polystat.dat
%filename = 'h2t.dat';%automatically choose polystat.dat

%fin = fopen(filename,'rt');

%new method
%M1 = fscanf(fin,'%f',[50,inf]);%import 6 column polystat.dat as a 6 row matrix
%O = M1(V,:); %select specific scalar function and construct 1-d O from that M1 matrix
%L = length(O);%real length, # of snapshots


%fclose(fin);
%load h2t.dat;
%load X;
%O = h2t;
load dist120.mat;
O = dist120;
L = length(O);

plot(O);

avg = mean(O);%find average of L h2t distances
Oa = O - avg;%modified sequence
C = zeros(T,1);%1-D autocorrelation ~ delay time

for t = 1:T%different delay time
    for j = 1:L-t%all h2t sequence
        C(t) = C(t) + Oa(j) * Oa(j+t);%multiply and summation
    end
    C(t) = C(t)/(L-t);%take average
end

figure;
plot(C);
figure;
scatter(1:50,C(1:50));


end

