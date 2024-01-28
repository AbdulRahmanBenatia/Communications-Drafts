function ber = BER_RicianChannel(bit_seq,symbols,M,K)

%RICIAN FADING
k1=10; %Rician factor
mean=sqrt(k1/(k1+1));% mean
sigma=sqrt(1/(2*(k1+1)));%variance
Nr2=randn(1,length(symbols))*sigma+mean;
Ni2=randn(1,length(symbols))*sigma;
%To generate the Rician Random Variable
No3=sqrt(Nr2.^2+Ni2.^2); %Rician fading coefficient
for k=0:1:10
    snrl=10^(k/10);%convert the SNR in dB value
    Np=1/snrl;%To generate the noise power
    sd=sqrt(Np/2);% standard deviation of guassian noise
    No=random('Normal',0,sd,1,length(symbols)); %Generates Gaussian noise
    t1=symbols.*No3+No; % s means transmitted signal...please take the value as u have taken
    z1=t1./No3;
    Decoded_seq=Demodulation(z1', M , K); % threshold detection
    ber(k+1)=sum(xor(Decoded_seq,bit_seq))/length(bit_seq); % observed BER
end

end