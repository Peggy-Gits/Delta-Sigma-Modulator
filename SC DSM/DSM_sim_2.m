function v=DSM_sim_2(fs, OSR)
  I1=25e-6;
  VFS=50e-3;
  C1=I1/(fs*1);
  R1=1/1/fs/C1;
  RB1=R1;
  C2=(I1/5)/fs;
  R2=1/C2/fs;
  RF1=R2/3;
  C2=C2*4;
  RF2=2*VFS/(I1/5);
  R3=RF2/4;%/4
  RB2=R2/3;
  A=[0 0;1/(R2*C2),0];
  B=[1/(R1*C1),-1/(RB1*C1);1/(RF1*C2),-1/(RB2*C2)];
  C=[0,R3*4/R3];
  D=[R3*4/RF2,0];
  B2=B(:,2);
  D2=[1,1];
  sys=ss(A+B2*C,[B(:,1),zeros(2,1)]+B2*D2,C,D2);
  set(sys,'InputDelay',0.5*[0 1])
  T=OSR*64-1;
  v=zeros(T+1,1);
  u=zeros(T+1,1);
  ts=1e-6;
  %x=zeros(2,1);
  states=zeros(2,T+1);
  for i=1:T+1
    u(i)=0.03*sin(2*pi*30*(i-1)*1/(T+1));
    x_prev=zeros(2,1);
    v_prev=0;
    if i>1
        x_prev=states(:,i-1);
        v_prev=v(i-1);
    end
    x=(ts*A+eye(2))*x_prev+ts*B*[u(i);v_prev];
    y=C*x_prev+D*[u(i);v_prev];
    states(:,i)=x;
    v(i)=sign(y)*0.05;
  end

  plot(1:T+1,v,1:T+1,u);
  plot(1:T+1,states)
end