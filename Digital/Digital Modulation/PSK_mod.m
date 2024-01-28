function [y_PSK,y_is,y_qs,in_phase_abs_vals,quad_abs_vals] = PSK_mod(bit_stream,Tb,dt,M)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

L = length(bit_stream);
% Binary
tt= 0:dt:L*Tb;
tb = 0:dt:Tb;
tb(end)=[];
A = sqrt(2/Tb);
f=1;
carrier_cos = A*cos(2*pi*f*tb);
% carriers=[carrier_1 carrier_2];

% M=4;

% if M==2
    y_phases=zeros(1,L);
    
    ones_ind = find(bit_stream==1);
    zeros_ind = find(bit_stream==0);
    
    y_phases(ones_ind)=1;
    y_phases(zeros_ind)=-1;
    y_PSK=[];
    for i=1:L
        y_PSK= [y_PSK y_phases(i)*carrier_cos];
    end

    in_phase_abs_vals=y_phases(1:2:end);
    quad_abs_vals=y_phases(2:2:end);
if M==4 %QPSK
    y_PSK=[];
    y_is=[];
    y_qs=[];
    carrier_sin =A*sin(2*pi*f*tb);
    just_a_counter=0;
    for i=1:2:L
        i
%         just_a_counter=just_a_counter+1;
%         if [bit_stream(i) bit_stream(i+1)] == [0 0]
%             y_phases(just_a_counter) = 1;
%         elseif [bit_stream(i) bit_stream(i+1)] == [0 1]
%             y_phases(just_a_counter) = 2;
%         elseif [bit_stream(i) bit_stream(i+1)] == [1 0]
%             y_phases(just_a_counter) = 3;
%         elseif [bit_stream(i) bit_stream(i+1)] == [1 1]
%             y_phases(just_a_counter) = 4;
%         end

        y_i= y_phases(i) * carrier_cos;
        y_i= repmat(y_i,1,2);
        y_is=[y_is y_i];
        y_q= y_phases(i+1) * carrier_sin;
        y_q= repmat(y_q,1,2);
        y_qs=[y_qs y_q];
        y_PSK=[y_PSK y_i+y_q];

    end

    y_PSK= [y_PSK y_PSK(end)];
    
    y_is= [y_is y_is(end)];
    y_qs= [y_qs y_qs(end)];

else
    y_is=[];
    y_qs=[];
    y_PSK= [y_PSK y_PSK(end)];
    plot(tt,y_PSK);

end


end