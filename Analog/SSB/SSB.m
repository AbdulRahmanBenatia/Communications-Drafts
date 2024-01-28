
f=20;
dt=1/f;
t=-5:dt:5;
the_sinc =sinc(t);
figure(1)
plot(t,the_sinc);
fc=10;

cosComp= the_sinc.*cos(2*pi*10*t);

dlt=zeros(1,length(t));
dlt(1,3430)=1;

shifted_sinc=cconv(dlt,the_sinc,length(the_sinc));

sinComp=shifted_sinc.*sin(2*pi*10*t);
s_lsb=cosComp+sinComp;
s_usb=cosComp-sinComp;
figure(2)
plot(s_usb)
figure(3)
plot(s_lsb)



%spectrum
frq_lower=fft(s_lsb);
frq_upper=fft(s_usb);
figure(4)
plot(abs(frq_lower))
figure(5)
plot(abs(frq_upper))


%demodulation
dm=s_lsb.*cos(2*pi*10*t);
%plot(dm)
 
dmbpf=4*bandpass(dm,[0.1 1],f);
figure(6)
plot(t,dmbpf)


%asynchronous
f1=fc+0.1;
f2=fc-0.1;

dm1=s_lsb.*cos(2*pi*f1*t);
dmbpf1=4*bandpass(dm1,[0.1 1],f);
figure(7)
plot(t,dmbpf1)

dm2=s_lsb.*cos(2*pi*f2*t);
dmbpf2=4*bandpass(dm2,[0.1 1],f);
figure(8)
plot(t,dmbpf2)


SSB_Signal_to_simin = horzcat(transpose(t),transpose(the_sinc));