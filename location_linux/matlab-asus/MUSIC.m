 function [AOA,error]=MUSIC(X,fc,c,M,N,dd,theta)
 
derad = pi/180;      %角度->弧度
d=0:dd:(N-1)*dd;
K=1;
% A=exp(-1i*2*pi*d.'*sin(theta*derad)*fc/c);  %方向矢量

% 计算协方差矩阵
Rxx=X*X'/K;
% 特征值分解
[EV,D]=eig(Rxx);                   %特征值分解
EVA=diag(D)';                      %将特征值矩阵对角线提取并转为一行
[EVA,I]=sort(EVA);                 %将特征值排序 从小到大
EV=fliplr(EV(:,I));                % 对应特征矢量排序
                 
% 遍历每个角度，计算空间谱
for i = 1:361
    angle(i)=(i-181)/2;
    phim=derad*angle(i);
    a=exp(-1i*2*pi*d*sin(phim)*fc/c).'; 
    En=EV(:,M+1:N);                   % 取矩阵的第M+1到N列组成噪声子空间
    Pmusic(i)=1/(a'*En*En'*a);
    MUSIC=[angle;Pmusic];
end
Pmusic=abs(Pmusic);
[Pmmax,idx]=max(Pmusic);
AOA=angle(idx);      %AOA角度
error=AOA-theta;     %误差
Pmusic=10*log10(Pmusic/Pmmax);            % 归一化处理

% h=plot(angle,Pmusic);
% set(h,'Linewidth',2);
% xlabel('到达角/(degree)');
% ylabel('空间谱/(dB)');
% set(gca, 'XTick',[-90:30:90]);
% grid on;
end

