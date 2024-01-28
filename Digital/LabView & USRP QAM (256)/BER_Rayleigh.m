function ber = BER_Rayleigh(bit_seq,symbols,M,k)

%rayleigh fading channel
n = length(symbols);
a=randn(1,n);%generates samples of size 1xn which are gaussian distributed
b=randn(1,n);%generates samples of size 1xn which are gaussian distributed
rc=1/sqrt(2)*(sqrt(a.^2+b.^2));%rayleigh channel
for l=0:1:10
    snr=10^((l/10));    % SNR values in absolute scale
    sdev=sqrt(0.5/snr); % standard deviation of noise calculated from SNR
    N=random('norm',0,sdev,[1,n]);% generation of noise sequence
    yrc=rc.*symbols+N;       %signal received through rayleigh and awgn channel
    YR=Demodulation(yrc', M , k); %baseband detection from Rayleigh,AWGN channel
    ErrorR=sum((xor(YR,bit_seq)));% no of errors in detected signal
    ber(l+1)=ErrorR/n;%simulated BER for AWGN,rayleigh channel
end

