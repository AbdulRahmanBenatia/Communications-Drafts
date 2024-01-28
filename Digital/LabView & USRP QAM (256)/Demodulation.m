function decoded_seq = Demodulation(rx_sig,M,k)
demodulated_seq = qamdemod(rx_sig', M);
decoded_seq = [];

for i=1:length(demodulated_seq)
    decoded_seq = [decoded_seq de2bi(demodulated_seq(i),k)];
end

end