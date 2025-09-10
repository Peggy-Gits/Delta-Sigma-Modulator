function [SNR, NBW, spec_win]=spec_analysis(OSR, tone_bin, u) 
Nfft=OSR*64;
win=hann(Nfft);
nb=3;
w1=norm(win,1);
w2=norm(win,2);
NBW=(w2/w1)^2;
v=u.*win;
spec_win=fft(v)/(w1/2);
f=linspace(0,0.5,Nfft/2+1);
plot(abs(spec_win(1:Nfft/2+1)));
%[~,tone_bin]=max(abs(spec_win));
signal_bins = tone_bin+(-(nb-1)/2:(nb-1)/2);
inband_bins = 0:Nfft/(2*OSR);
noise_bins = setdiff(inband_bins,signal_bins);
SNR = dbp(sum(abs(spec_win(signal_bins+1)).^2)/ sum(abs(spec_win(noise_bins+1)).^2));
end