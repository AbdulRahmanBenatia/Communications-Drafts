% testing fsk

% Testing Signal
b= [1 0 1 0 0 1];
L=length(b);
Tb=2;
dt=0.001;
tt= 0:dt:L*Tb;
tb = 0:dt:Tb;
tb(end)=[];

zero_bit=zeros(1,length(tb));
one_bit=ones(1,length(tb));
sig_test=[];
for i=1:L
    if(b(i)==1)
        sig_test=[sig_test one_bit];
    else
        sig_test=[sig_test zero_bit];
    end
end
sig_test_p=[sig_test sig_test(end)];
figure(1)
plot(tt,sig_test_p)
title('Binary testing Signal')
xlabel('time')
ylabel('amplitude')

% Modulation
f1=1;
f2=10;
modulated= FSK_Mod(b,Tb,1,dt,f1,f2);
length(modulated)
length(tt)
figure(2)
plot(tt,modulated);
title('(BFSK) Modulated Signal')
xlabel('time')
ylabel('amplitude')