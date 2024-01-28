%Programme to plot the BER performance curves for coherent and non-coherent
%binary FSK.

%Written by Andrew Bateman.

%set up figure numbers and location on the screen

figure(1)
close
h=figure('position',[90 341 394 369],'color',[1,1,0]);
h=axes('position',[100,331,404,379],'color',[0,1,0]);
clf

%initialise vectors

Pcohfsk=[];
Pnoncfsk=[];
xaxis1=[];
xaxis2=[];

%Calculate BER results

for j = 1:100 
i=j/5;
EbNo=10^(i/10);
cohfsk= 0.5*(erfc(sqrt(EbNo/2)));
if cohfsk < 1e-6, ,break, end
Pcohfsk(j)=cohfsk;
xaxis1(j)=i;
end

for j = 1:10000
i=j/5;
EbNo=10^(i/10);
noncfsk=0.5*exp(-EbNo/2);
%if noncfsk < 1e-6, ,break, end
Pnoncfsk(j)=noncfsk;
xaxis2(j)=noncfsk;
end

figure(1)
semilogy(xaxis1,Pcohfsk,'-g','linewidth',2);
hold on
semilogy(xaxis2,Pnoncfsk,'-y','linewidth',2);
title('BER curves for FSK')

