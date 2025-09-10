function sys=finite_gain_sim(A,C,R)
s=tf('s');
a=-(1/A+1)*C;
b=1/(R*a);
AI=1/A*b;
BI=b;
CI=1;
DI=0;
sys=ss(AI,BI,CI,DI);
sys=zpk(sys);
end
