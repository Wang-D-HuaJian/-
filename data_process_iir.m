%% ��Ҫ���������ݽ��д����ݲ����˲�
close all;
clear all;
clc;
%
open('RAW.fig');
obj=get(gca,'Children');%get line handles
xdata=get(obj,'Xdata');
ydata=get(obj,'Ydata');
%
fs=512;
Ts=1/fs;
t_all=360;
N=184320;
y=[ydata zeros(1,171)];
%% �ݲ��� 
f0=50;%�ݲ�����Ƶ��
apha=-2*cos(2*pi*f0*Ts);
beta=0.95;
b=[1 apha 1];
a=[1 apha*beta beta^2];
% figure(3);%�˲�����������ʾ
% freqz(b,a,N,fs);
% title('�ݲ�������'); 
% �ݲ����˲�����
y1=dlsim(b,a,y)';%�����ݲ���������ź�
%
y2=bandpass_filter(y1,8,12,6,14,3,30,fs);%������ͨ�˲���
%
%% ���ڵõ����źŻ�Ҫ������������һ��ƽ�����ܹ���ʱ����360s����ÿһ���ڵ��ź�����ƽ��
 % ԭʼ�Ĳ���Ƶ����512�����ڵõ���Ƶ����Χ�� 8-12 Hz ��6-14 Hz��
 y_processed=zeros(1,t_all);
 for i=1:t_all
     sum=0;
  for j=1:fs
      sum=sum+y2(1,(i-1)*fs+j)^2;
  end
     y_processed(1,i)=sum/fs;
     
 end
 %figure(2);
 %plot(y_processed);
 figure(3)
stem(abs(fft(y2)));