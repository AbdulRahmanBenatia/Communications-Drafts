function y_QAM = QAM_mod(bit_stream,Tb,dt)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


L = length(bit_stream);
tt= 0:dt:L*Tb;
tb = 0:dt:Tb;
tb(end)=[];
A = sqrt(2/Tb);
f=1;
carrier_cos = A*cos(2*pi*f*tb);
carrier_sin =A*sin(2*pi*f*tb);
gray_codes = ["1011" ,"1001","1110","1111";
               "1010","1000","1100","1101";
               "0001","0000","0100","0110";
               "0011","0010","0101","0111"];

bs=[3,1,-1,-3]; %rows
as=[-3,-1,1,3]; %cols

y_phases=zeros(1,L);
ones_ind = find(bit_stream==1);
zeros_ind = find(bit_stream==0);
y_phases(ones_ind)=1;
y_phases(zeros_ind)=-1;
% for i=1:L
%     y_PSK= [y_PSK y_phases(i)*carrier_cos];
% end

in_phase_abs_vals=y_phases(1:2:end);
quad_abs_vals=y_phases(2:2:end);
y_is=[];
y_qs=[];
y_QAM=[];
just_a_counter=0;
for i=1:4:L

    s= strjoin(string(bit_stream(i:i+3)),'');
    [r,c]= find(gray_codes==s);
    as(c);
    y_i= A*as(c).*carrier_cos;
    y_i=repmat(y_i,1,4);
    y_is=[y_is y_i];
    y_q= A*bs(r).*carrier_sin;
    y_q=repmat(y_q,1,4);
    y_qs=[y_qs y_q];
    y_QAM=[y_QAM y_i+y_q];




end

y_QAM= [y_QAM y_QAM(end)];

y_is= [y_is y_is(end)];
y_qs= [y_qs y_qs(end)];
plot(tt,y_QAM)


end