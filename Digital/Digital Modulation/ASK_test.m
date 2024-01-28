%This is just to test the m_ary_ASK_mod function....

% generate random sqaure 0-1 signal... (Unipolar NRZ), this is the current
% implementation but can be easily modified
factor_for_num_bits=5;
m=8;
sig_num_bits=factor_for_num_bits*log2(m);
tt= 0:0.001:sig_num_bits;
zero_bit=zeros(1,1000);
one_bit=ones(1,1000);
sig_test=[];
for i=1:sig_num_bits
    r=randi([0,1],1);
    if(r==1)
        sig_test=[sig_test one_bit];
    else
        sig_test=[sig_test zero_bit];
    end
end
sig_test_p=[sig_test sig_test(end)];

figure(55)
plot(tt,sig_test_p)
title('Original Testing Signal')
xlabel('time')
ylabel('Amplitude')


modulated= m_ary_ASK_mod(sig_test_p,1,5,m,1,tt);
figure(10)
plot(tt,modulated)
title('ASK-Modulated Signal')
xlabel('time')
ylabel('Amplitude')


% % Demod::
demod =m_ary_ASK_demod(modulated,1,m,1,tt,sig_num_bits);

figure(1111)
plot(tt,demod)
title("Demodulated - HAPPY ENDING")
xlabel('time')
ylabel('Amplitude')


difference= sum(demod~=sig_test_p) % 0 means perfectly mod & demodulated.