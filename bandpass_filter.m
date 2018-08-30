% 巴特沃斯带通滤波器设计
%
function y=bandpass_filter(x,f1,f3,fs1,fs3,rp,rs,Fs)
%--滤波器参数设置
% f1 :通带左边界
% f3 :通带右边界
% fsl:衰减截止左边界
% fs3:衰减截止右边界
%rp：通带文波
%rs：阻带衰减
%FS：序列x的采样频率
%首先要把模拟频率转换成数字频率
wp1=2*pi*f1/Fs;
wp3=2*pi*f3/Fs;
ws1=2*pi*fs1/Fs;
ws3=2*pi*fs3/Fs;
wp=[wp1,wp3];
ws=[ws1,ws3];
% 设计切比雪夫
% [n,wp]=cheb1ord(wp/pi,ws/pi,rp,rs);
% [b,a]=cheby1(n,rp,wp/pi);
%
[n,wn]=buttord(wp/pi,ws/pi,rp,rs);
[b,a]=butter(n,wn);%这里得到的就是数字滤波器的参数
%
%freqz(b,a,184320,fs);
% 查看滤波器的曲线
[h,w]=freqz(b,a,256,Fs);
h=20*log10(abs(h));
figure(1);
plot(w,h);title('所设计的滤波器通带曲线');
y=filter(b,a,x);
end