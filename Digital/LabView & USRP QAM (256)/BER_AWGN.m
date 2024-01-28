function ber = BER_AWGN(bit_seq,symbols,M,k)

%AWGN fading channel
n = length(symbols);
for l=0:1:10
    snr=10^((l/10));    % SNR values in absolute scale
    sdev=sqrt(0.5/snr); % standard deviation of noise calculated from SNR
    N=random('norm',0,sdev,[1,n]);% generation of noise sequence
    yawgn=symbols+N;         %signal received through awgn channel
    Yb=Demodulation(yawgn', M , k);% baseband signal detection from awgn channel
    ErrorA=sum((xor(Yb,bit_seq)));
    ber(l+1)=ErrorA/n;% simulated BER for awgn channel
end
end