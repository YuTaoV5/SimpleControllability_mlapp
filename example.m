
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
syms t tt

%% 格拉姆矩阵Wc
Wc=int( expm(A*t)*B*B'*expm(A'*t) ,0,t1)

%% 构造矩阵u
u=( -B'* expm(A'*(t1-t))/Wc ) * expm(A*t1)*x0

%% 计算x
xt = expm(A*tt)*x0 + int( expm(A*(tt-t))*B*u , 0 , tt)

%% 数据转换
x = linspace(0,t1)
y1 = char(u)
y1 = strrep(y1,"*",".*")
y1 = strrep(y1,"^",".^")
y1 = strrep(y1,"t","x")
eval(['y1=',char(y1),';']);
%%
y2 = char(xt(1))
y2 = strrep(y2,"*",".*")
y2 = strrep(y2,"^",".^")
y2 = strrep(y2,"tt","x")
eval(['y2=',char(y2),';']);
%%
y3 = char(xt(2))
y3 = strrep(y3,"*",".*")
y3 = strrep(y3,"^",".^")
y3 = strrep(y3,"tt","x")
eval(['y3=',char(y3),';']);

%% 绘图
plot(x,y1,'LineWidth',3)
hold on
plot(x,y2,'LineWidth',3)
plot(x,y3,'LineWidth',3)
grid on
