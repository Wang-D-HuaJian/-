function w=conv_my(f,g)

% ����ľ���������Ծ��������Բ�ܾ�����������еĳ���Ҫ��֤��һ����
% Ҫ�����Բ�ܾ����ʱ�䷴ת��������ô���
%
N=length(f);
w=zeros(1,N);
g=[g zeros(1,N-length(g))];
%
g1=zeros(1,N);
%
% n=1 �����
%
g1(1,1)=g(1,1);
for i=2:N
    %
    g1(1,i)=g(1,N+2-i);
    %
end
w(1,1)=sum(f.*circshift(g1,1));
%
%
%
for n=2:N
    g=circshift(g1,[0,n-1]);%����ѭ��ƽ�ƣ�����0�У�����n��
    w(n)=sum(f.*g);%��Ӧλ����������
end

end

 
