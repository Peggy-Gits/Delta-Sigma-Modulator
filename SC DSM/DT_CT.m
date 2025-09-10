function a=DT_CT(x,mu,Tsa)
 z=tf('z',1);
 s=tf('s');
 % H4=z/(z-1);
 % H5=x(2)/x(3)+z/(z-1);
 % H6=1/(z-1);
 % L1=(x(3)*H4*H5*H6+x(1)*H6);
 % NTF=zpk(1/(1+L1));
 % t=0:Tsa:10*Tsa;
 % y_d=impL1(NTF,10)';
 
 int=1/(z-1);
 L1=x(1)*int*int+x(2)*int;
 NTF=zpk(1/(1+L1));
 y_d=impL1(NTF,10)';
 %% find continuous equivalent
 % Ac= [0 0 0; 1 0 0; 0 1 0];
 % Bc= [-1 0 0 0; 0 -1 0 0; 0 0 -1 0];
 % Cc= [0 0 1];
 % Dc= [0 0 0 -1];
 Ac= [0 0; 1 0];
 Bc= [-1 0; 0 -1];
 Cc= [0 1];
 Dc= [0 0];
 sys_c=ss(Ac,Bc,Cc,Dc);
 %set(sys_c,'InputDelay',0.5*[1 1 1 1])
 set(sys_c,'InputDelay',0.5*[1 1])
 sys_d=c2d(sys_c,1);
 y_c=squeeze(impulse(sys_d,0:10))';
 
 a=y_d/y_c;

 

 %A=[1/mu(1),mu(2)/mu(1)^2,mu(2)^2/mu(1)^3-(mu(2)+mu(3))/(2*mu(1)^2);0,1/mu(1),1/mu(1)*(mu(2)/mu(1)-1/2);0,0,1/mu(1)];
 A=[mu(1) -mu(2); 0 mu(1)];
 %a=A\x;
 a=A*x';
end