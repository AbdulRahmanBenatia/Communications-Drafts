function demod_stream = FSK_demod(x_recieved, f1,f2,N_syms,A,tb)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

phi1 = A*sin(2*pi*f1*tb);
phi2 = A*sin(2*pi*f2*tb);

step = 2000;
demod_stream=zeros(1,N_syms);
just_a_counter=0;
for i=1:step:length(x_recieved)
    if(just_a_counter>=N_syms)
        break;
    end
    just_a_counter=just_a_counter+1;
% Correlation with phi1 & phi2 
    x1 = sum(x_recieved(i:i+step-1).*phi1);
    x2 = sum(x_recieved(i:i+step-1).*phi2);
% Subtract 
    y = x1-x2;
% Decide 
    if(y>0)
        demod_stream(just_a_counter)=1;
    else
        demod_stream(just_a_counter)=0;
    end
end



end