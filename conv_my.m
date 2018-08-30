function w=conv_my(f,g)

% 这里的卷积不是线性卷积，而是圆周卷积，两个序列的长度要保证是一样的
% 要搞清楚圆周卷积的时间反转序列是怎么求的
%
N=length(f);
w=zeros(1,N);
g=[g zeros(1,N-length(g))];
%
g1=zeros(1,N);
%
% n=1 的情况
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
    g=circshift(g1,[0,n-1]);%矩阵循环平移，下移0行，右移n列
    w(n)=sum(f.*g);%对应位置相乘再求和
end

end

 
