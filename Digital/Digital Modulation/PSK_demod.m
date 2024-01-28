function demod_stream = PSK_demod(x_recieved,f,N_syms,A,Tb,dt,M)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
tb = 0:dt:Tb;
phi1 = A*cos(2*pi*f*tb);
phi2 = A*sin(2*pi*f*tb);
if(M==2)
    phi2=zeros(1,length(tb));
end

step = Tb/dt;
length(tb);

m=log2(M);
% demod_stream=zeros(1,N_syms);
demod_stream=[];
just_a_counter=0;
for i=1:step*m:length(x_recieved)
    if(just_a_counter>=N_syms/m)
        break;
    end
    just_a_counter=just_a_counter+1;
%     correlate 
    x1 = sum(x_recieved(i:i+step).*repmat(phi1,1,1));
    x2 = sum(x_recieved(i:i+step).*repmat(phi2,1,1));
% decide
    if(x1>0)
        demod_stream=[demod_stream 1];

    else 
        demod_stream=[demod_stream 0];
    end
    just_a_counter;
    if(M==4)            %QPSK
        if x2>0
            demod_stream=[demod_stream 1];
        else

            demod_stream=[demod_stream 0];
        end
    end
end




end