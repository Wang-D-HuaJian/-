%% 主要用来对数据进行处理，陷波，滤波
close all;
clear all;
clc;
%
open('RAW.fig');
obj=get(gca,'Children');%get line handles
xdata=get(obj,'Xdata');
ydata=get(obj,'Ydata');
A=load('fir2.mat');
fir=A.a;
%
fs=250;
Ts=1/fs;
t_all=360;
N=184320;
y=[ydata zeros(1,171)];
%% 陷波器 
f0=50;%陷波器的频率
apha=-2*cos(2*pi*f0*Ts);
beta=0.95;
b=[1 apha 1];
a=[1 apha*beta beta^2];
figure(3);%滤波器的特性显示
freqz(b,a,N,fs);
%陷波器滤波处理
y1=dlsim(b,a,y)';%经过陷波器处理的信号
%% 加带通滤波器

y2=conv(y1,fir);
fir=[fir zeros(1,N-length(fir))];
y3=ifft(fft(y1).*fft(fir));
%
%% 现在得到的信号还要算能量，再做一个平均，总共的时间是360s，将每一秒内的信号能量平均
 % 原始的采样频率是512，现在得到的频带范围是 8-12 Hz （6-14 Hz）
 y_processed=zeros(1,t_all);
 for i=1:t_all
     sum=0;
  for j=1:fs
      sum=sum+y2(1,(i-1)*fs+j)^2;
  end
     y_processed(1,i)=sum/fs;
     
 end
%  figure(2);
%  plot(y_processed);
%  figure(3)
% plot(y2);
% figure(4)
% stem(abs(fft(y3)));