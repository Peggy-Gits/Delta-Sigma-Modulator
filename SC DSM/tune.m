function SNR=tune(x,osr,Tsa)
  z=tf('z',Tsa);
  s=tf('s');
  H1=1/s;
  x_ct=DT_CT(x,[1,0,0],Tsa);
  x_ct=x;
  L1_ct=x_ct(3)/s^3+x_ct(2)/s^2+x_ct(1)/s;
  NTF_ct=1/(1+L1_ct);
  
  H4=z/(z-1);
  H5=x(2)/x(3)+z/(z-1);
  H6=1/(z-1);
  L1=(x(3)*H4*H5*H6+x(1)*H6);
  NTF=1/(1+L1);
  [h,~]=freqz(NTF.Numerator{1,1},NTF.Denominator{1,1},0:0.001:1/osr*pi);
  SNR=20*log10(abs(h(end)));
  figure 
  bode(NTF,NTF_ct);
  figure 
  freqz(NTF.Numerator{1,1},NTF.Denominator{1,1},1000);
end