clc
clear
tic
date = 1117;
k = 4;
filename = strcat('data/AP', num2str(k), '_00.pcap');
% filename = strcat('raw_csi2/csidata_4ant_', num2str(date), '_AP', num2str(k), '_1.pcap');
% csi_all = read_file(filename);
csi_r = read(filename);
% c = csi_all - csi_r;
