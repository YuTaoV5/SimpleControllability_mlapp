%% Matlab版本2020a Edited by 张聿韬
clc
clear
close all
%% 状态空间
A=[-0.5 0;0 -1];
B=[0.5;1];
%% 可控性判别
Qc=ctrb(A,B);
nc=rank(Qc);
if nc==rank(A)
    disp("可控");
else
    disp("不可控");
end
%% 求状态转移矩阵
% 求状态转移可以不用反拉氏变换, 直接expm就好
% I=[1 0;0 1];
% E=s*I-A;
% D=collect(inv(E));
% trans=ilaplace(D)
%% 格拉姆矩阵判据
syms t t1 s x0 x1
Wc=int( expm(A*t)*B*B'*expm(A'*t) ,0,t1)
%% t=2
Wc_2=int( expm(A*t)*B*B'*expm(A'*t) ,0,2)
%% 求u
u=-B'* expm(A'*(t1-t)) * inv(Wc)*(exp(t1)*x0-x1)
%% 求u_1
temp = [exp(-1) 0;0 exp(-2)]*[10;-1]
u_1=( -B'* expm(A'*(2-t))/Wc_2 ) * temp 
%% 验证 t=1s 时上式结果是不是接近
tt=1
ans_u = -58.82*exp(0.5*tt)+27.96*exp(tt)
my_u = (3656975586926937*exp(3)*exp(tt/2 - 1)*(2*exp(1) + 2*exp(2) - 3*exp(1)*exp(tt/2 - 1) - 3*exp(2)*exp(tt/2 - 1) + 2))/(4503599627370496*(exp(1) - 8*exp(2) + 8*exp(3) - exp(4) - exp(5) + 1)) - (12425862856327305*exp(2)*exp(tt/2 - 1)*(3*exp(1) + 3*exp(2) + 3*exp(3) - 4*exp(1)*exp(tt/2 - 1) - 4*exp(2)*exp(tt/2 - 1) - 4*exp(3)*exp(tt/2 - 1) + 3))/(562949953421312*(exp(1) - 1)*(2*exp(1) - 6*exp(2) + 2*exp(3) + exp(4) + 1))
if abs(ans_u-my_u)<0.05
    disp("计算正确")
else
    disp("计算错误")
end
%% 绘图
x = linspace(0,2)
y = (3656975586926937.*exp(3).*exp(x/2 - 1).*(2.*exp(1) + 2.*exp(2) - 3.*exp(1).*exp(x/2 - 1) - 3.*exp(2).*exp(x/2 - 1) + 2))/(4503599627370496.*(exp(1) - 8.*exp(2) + 8.*exp(3) - exp(4) - exp(5) + 1)) - (12425862856327305.*exp(2).*exp(x/2 - 1).*(3.*exp(1) + 3.*exp(2) + 3.*exp(3) - 4.*exp(1).*exp(x/2 - 1) - 4.*exp(2).*exp(x/2 - 1) - 4.*exp(3).*exp(x/2 - 1) + 3))/(562949953421312.*(exp(1) - 1).*(2.*exp(1) - 6.*exp(2) + 2.*exp(3) + exp(4) + 1))
plot(x,y,'LineWidth',3)
legend('u_1');
grid on




%%
%　我是可爱的分界线　％

%% 格拉姆矩阵判据
% Matlab版本2020a 
% Edited by 张聿韬
% 能控性判别V2.0
clc
clear
close all

%% 状态空间
A=[-0.5 0;0 -1];
B=[0.5;1];
x0=[10;-1];
t1=2;
syms t

%% 格拉姆矩阵Wc
Wc=int( expm(A*t)*B*B'*expm(A'*t) ,0,t1)

%% 构造矩阵u
u=( -B'* expm(A'*(t1-t))/Wc ) * expm(A*t1)*x0

%% 数据转换
x = linspace(0,t1)
y = char(u)
y = strrep(y,"*",".*")
y = strrep(y,"t","x")
eval(['y=',char(y),';']);
%% 绘图
plot(x,y,'LineWidth',3)
legend('u的变化曲线');
grid on