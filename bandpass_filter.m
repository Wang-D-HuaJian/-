% ������˹��ͨ�˲������
%
function y=bandpass_filter(x,f1,f3,fs1,fs3,rp,rs,Fs)
%--�˲�����������
% f1 :ͨ����߽�
% f3 :ͨ���ұ߽�
% fsl:˥����ֹ��߽�
% fs3:˥����ֹ�ұ߽�
%rp��ͨ���Ĳ�
%rs�����˥��
%FS������x�Ĳ���Ƶ��
%����Ҫ��ģ��Ƶ��ת��������Ƶ��
wp1=2*pi*f1/Fs;
wp3=2*pi*f3/Fs;
ws1=2*pi*fs1/Fs;
ws3=2*pi*fs3/Fs;
wp=[wp1,wp3];
ws=[ws1,ws3];
% ����б�ѩ��
% [n,wp]=cheb1ord(wp/pi,ws/pi,rp,rs);
% [b,a]=cheby1(n,rp,wp/pi);
%
[n,wn]=buttord(wp/pi,ws/pi,rp,rs);
[b,a]=butter(n,wn);%����õ��ľ��������˲����Ĳ���
%
%freqz(b,a,184320,fs);
% �鿴�˲���������
[h,w]=freqz(b,a,256,Fs);
h=20*log10(abs(h));
figure(1);
plot(w,h);title('����Ƶ��˲���ͨ������');
y=filter(b,a,x);
end