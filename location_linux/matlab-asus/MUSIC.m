 function [AOA,error]=MUSIC(X,fc,c,M,N,dd,theta)
 
derad = pi/180;      %�Ƕ�->����
d=0:dd:(N-1)*dd;
K=1;
% A=exp(-1i*2*pi*d.'*sin(theta*derad)*fc/c);  %����ʸ��

% ����Э�������
Rxx=X*X'/K;
% ����ֵ�ֽ�
[EV,D]=eig(Rxx);                   %����ֵ�ֽ�
EVA=diag(D)';                      %������ֵ����Խ�����ȡ��תΪһ��
[EVA,I]=sort(EVA);                 %������ֵ���� ��С����
EV=fliplr(EV(:,I));                % ��Ӧ����ʸ������
                 
% ����ÿ���Ƕȣ�����ռ���
for i = 1:361
    angle(i)=(i-181)/2;
    phim=derad*angle(i);
    a=exp(-1i*2*pi*d*sin(phim)*fc/c).'; 
    En=EV(:,M+1:N);                   % ȡ����ĵ�M+1��N����������ӿռ�
    Pmusic(i)=1/(a'*En*En'*a);
    MUSIC=[angle;Pmusic];
end
Pmusic=abs(Pmusic);
[Pmmax,idx]=max(Pmusic);
AOA=angle(idx);      %AOA�Ƕ�
error=AOA-theta;     %���
Pmusic=10*log10(Pmusic/Pmmax);            % ��һ������

% h=plot(angle,Pmusic);
% set(h,'Linewidth',2);
% xlabel('�����/(degree)');
% ylabel('�ռ���/(dB)');
% set(gca, 'XTick',[-90:30:90]);
% grid on;
end

