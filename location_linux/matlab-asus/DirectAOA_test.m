clear;

% distance=Distance('data/raw_csi/data_classroom/csi01_1.dat');
% distance=distance();
data=xlsread('data/temporary_data/AOATOF.xls');
% data=[data,distance];
% AOATOF = load('AOA_TOF.mat');
% data = AOATOF.AOATOF;
% 数据聚类
[idx, ctr] = KmeansCluster(data, 5, 1000);
[m, n] = size(idx);

% 显示聚类后的结果
figure();
hold on;
for i=1:m
    if idx(i, 4) == 1
        plot(idx(i, 1), idx(i, 2), 'r^', 'MarkerSize', 10); 
    elseif idx(i, 4) == 2
        plot(idx(i, 1), idx(i, 2), 'bo', 'MarkerSize', 10);
    elseif idx(i, 4) == 3
        plot(idx(i, 1), idx(i, 2), 'g*', 'MarkerSize', 10);
    elseif idx(i, 4) == 4
        plot(idx(i, 1), idx(i, 2), 'kx', 'MarkerSize', 10);
    else
        plot(idx(i, 1), idx(i, 2), 'm>', 'MarkerSize', 10);
    end
end
xlabel('TOF','FontSize',20,'FontWeight','bold');
ylabel('AOA','FontSize',20,'FontWeight','bold');
set(legend('cluster 1','cluster 2','cluster 3','cluster 4','cluster 5'),'FontSize',20,'FontWeight','bold','Location','northeast');
hold off;

[likehood,Xaoa,distance] = DirectPathAoA(idx);

data=[likehood,Xaoa,distance];
[m, n] = size(data);            
data_cell = mat2cell(data, ones(m,1), ones(n,1));
title={'likehood','AOA','distance'};
result = [title; data_cell];    
xlswrite('data/temporary_data/likehood_AOA_distance.xls',result);
