function y_demod = m_ary_ASK_demod(mod_signal,f_signal,m,scale_factor,tt,num_bits)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% ***********************************************************
% Inputs:
%       - mod_signal: m-ary ASK modulated signal
%       - f_signal: signal freq
%       - m itself
%       - scale_factor: the amplitudes scale factor in mod
%       - tt: the time vector (Can be removed now)
%       - num_bits: number of bits in the mod signa, (NOT needed anymore)
% Output:
%       -y_demod: signal after denodulation (unipolar NRZ).
% ***********************************************************
% Remember our convention in modulation, the voltage is the value
% corresponding to the binary representaion of the log_2(m) bits, scaled by
% some factor, if you wish...


dt_carrier=0.001;
% tt= -10:dt_carrier:11;  %we chose now to take it from main testing...
% figure(210)
% plot(tt,mod_signal)
% title("Signal input at DEMOD")
% xlabel('time')
% ylabel('Amplitude')

volt_levels_array=scale_factor*(1:log2(m));
bit_duration=1/f_signal;
bit_duration_as_in_time_indices= bit_duration/dt_carrier;
symbol_duration=log2(m) * bit_duration_as_in_time_indices;
signal_to_generate=[];
important_counter=0;
for i=1:symbol_duration:length(mod_signal)
    important_counter=important_counter+1;
%     just_a_counter=just_a_counter+1;
%     if any(volt_levels_array==signal(i))
%         signal_to_generate(i)=volt_levels_array(find(volt_levels_array==mod_signal(i)));
%     smth__="HERE";
    if i~=length(mod_signal)
%         max(mod_signal(i:i+900));
        smth_to_store=max(mod_signal(i:i+900));
        signal_to_generate=[signal_to_generate dec2bin(smth_to_store,log2(m))];
    end

end

%now, generate the signal::
y_demod=[];
% very_important_counter=0;
% for i=1:3:length(signal_to_generate)
%     very_important_counter=very_important_counter+1;
%     if i<(length(signal_to_generate)-log2(m)+1)
%         signal_to_generate(i:i+log2(m)-1);
%         sometext='rev_bin'
%         rev_bin=reverse(signal_to_generate(i:i+log2(m)-1))
%     end
%     if mod(i,log2(m))==1
%         for j=1:length(rev_bin)
%             y_demod =[y_demod str2num(rev_bin)];
%         end
%     end
% end
% for i=1:log2(m):length(signal_to_generate)
%     if i<(length(signal_to_generate)-log2(m)+1)
%         signal_to_generate(i:i+log2(m)-1);
%         sometext='rev_bin'
%         rev_bin=reverse(signal_to_generate(i:i+log2(m)-1));
%     end
%     if mod(i,log2(m))==1
%         y_demod =[y_demod str2num(rev_bin)];
%     end
% 
% end
% rev_bin=reverse(signal_to_generate);
for i=1:1:length(signal_to_generate)
    y_demod=[y_demod str2num(signal_to_generate(i))];
end

% length(y_demod)
% length(mod_signal)
% length(signal_to_generate)
% signal_to_generate
% signal_to_generate(1:num_bits)
% y_demod;
% y_demod=repelem(y_demod(1:num_bits),1000);
% y_demod=[y_demod 1];
% symbol_duration;
% ldm=length(y_demod);
% length(mod_signal);
%extend size:::

y_demod=repelem(y_demod,1000);
y_demod=[y_demod y_demod(end)];

% seems like one element is missing at the end, so just pad it, it is extra
% 0 anyway..
% y_demod=[y_demod y_demod(end)]
end