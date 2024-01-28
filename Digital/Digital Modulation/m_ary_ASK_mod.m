function [y_modulated] = m_ary_ASK_mod(signal,f_signal,f_carrier,m,scale_factor,tt)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% ***********************************************************
% Inputs: 
%       - signal: the one to be modulated
%       - f_signal: frequency of the signal
%       - f_carrier: desired carrier frequency
%       - m: order of modulation (2 for binary, 8 for 8-ary, and so on,,
%            MUST be a power of 2).
% Output:
%       -y_modulated: the m-ary ASK modulated signal (unipolar NRZ.
% ***********************************************************

% VERY IMPORTANT NOTE:::::: number of bits in the modulating signal MUST be
% a multiple of log2(m).

bit_duration=1/f_signal; %in time units..
dt_carrier= 0.001;
bit_duration_as_in_time_indices= bit_duration/dt_carrier; %in samples

num_bits=(length(signal)-1)/bit_duration_as_in_time_indices
if mod(num_bits,log2(m))~=0
    disp("INVALID! Number of bits MUST be a multiple of log2(m).")
    return;   %Should be here but forget it for now
end


% figure(5)
% figure(500)
% plot(tt,signal);
% title('signal at mod inp')
% xlabel('time')
% ylabel('Amplitude')

%generate carrier
carrier= sin(2*pi*f_carrier*tt);
%plot carrier
% figure(1)
% plot(tt,carrier)
% title('Carrier Signal')
% xlabel('time')
% ylabel('carrier amp')

if length(signal)<length(tt)
    signal=[signal zeros(1,(length(tt)-length(signal)))];
end 
%modulate:: 1 sample:


%modulate for m-ary::
%m= 4 ,,, numsymbols= log_2(4)
% num_symbols=2;
% % 00 01 10 11
% % plot(tt,signal)
% % array 
% % [0 1]
% % [00 01 10 11]
% % [000 001 010 011 100 101 110 111]
% % construcrt an array with length= m ,, with values assigned to indices 
% % that represent the (index-1) in log_2(m) bits representation, these values in
% % the array are the corresponding transmitted (Modulation) amplitudes of 
% % its element::::  array[1] is for all zeros bits of the modulating signal.
% % And... let is just keep the values = to indices -1 
% % so: all zeros is 0V, 1 is 1V, and so on....
% len_array= 2^num_symbols;
% mod_amp_array=zeros(1,len_array);
% for i=1:2^num_symbols
%     mod_amp_array(i)=i;
% end

%now, check input_signal and assign the corresponding Amp to the mod...
% but, how to check it??
% well, we need Tb, and check value at times spaced with log_2(m)
% Note: it is just 0 or 1, the matter is how many of the log_2(m) bits..
% y_modulated_ind=zeros(1,ceil(length(signal)/log2(m)));

% y_modulated_ind=zeros(1,ceil(log2(m)));
y_modulated_ind=zeros(1,ceil(log2(m)));

% Here, you might ask a question in the above line, and another in the
% below one,, those are:
%                       1- Why ceil?
%                       2- Why bit_duration+3?
% But don't worry, I also do not know XD, especially the 3 could have
% been many things else.
count_zeros=0;
count_ones=0;
just_a_counter=0;
loop_number_to_append=0;



for i=1:bit_duration_as_in_time_indices:length(signal)
    just_a_counter=just_a_counter+1;
    if signal(i)==0
        count_zeros= count_zeros+ 1;
    else
        count_ones= count_ones+ 1;
        loop_number_to_append =loop_number_to_append+(2^(log2(m)-1-mod(just_a_counter-1,log2(m))));
%         looks cool, isn't it?
    end

    if (count_zeros+count_ones)==log2(m) 
%   ummmmmm,, seems like we need some Math.. ok ok... look above and below.
        y_modulated_ind(just_a_counter/log2(m))= loop_number_to_append;
        count_zeros=0;
        count_ones=0;
        loop_number_to_append=0;
    end
end




y_modulated_amplitudes=scale_factor.*y_modulated_ind;

%well, there is a built-in function to buit it
% for i=1:length(y_modulated_amplitudes)
%     if(i==1)
%         y_modulated_amplitudes=[y_modulated_amplitudes(i) y_modulated_amplitudes(i)*ones(1,999)]
%     else
%         y_modulated_amplitudes=[y_modulated_amplitudes(i) y_modulated_amplitudes(i)*ones(1,999)]
% 
% end
%well, there is a built-in function to buit it

y_modulated_amplitudes=repelem(y_modulated_amplitudes,1/dt_carrier);


%now,, time for the signal itself...

y_modulated=y_modulated_amplitudes.*carrier(1:length(y_modulated_amplitudes));

y_mod_rep=repelem(y_modulated,log2(m));
y_mod_rep=[y_mod_rep y_mod_rep(end)];


if(num_bits~=log2(m))
    y_modulated=y_mod_rep;
else
    y_modulated=[y_modulated y_modulated(end)]
end



end