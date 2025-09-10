function [h,w]=stability(a,Tsa,OSR,A) 
    z=tf('z',Tsa);
    H=1/(z*(1+1/A)-1*(1+1/A));
    L=a(1)*H^2+a(2)*H;
    NTF=1/(1+L)*1/(1+H);
    Nfft=32*OSR;
    [h,w]=freqz(NTF.Numerator{1},NTF.Denominator{1},Nfft);
    BW=(0:Nfft/OSR)/pi;
    mag=abs(h(1:Nfft/OSR+1));
    plot(BW,20*log10(mag));
end