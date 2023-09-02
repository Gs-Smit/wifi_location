clear

filename = 'raw_csi2/csidata_4ant_1117_AP1_8.pcap';
csi_all = read_file(filename);
[m,n]=size(csi_all([1:900],:));
csi_plot = fftshift(csi_all([1:900],:),2);

csi_index=csi_phase_filter(csi_all([1:900],:));
csi_filter=csi_phase_filter(csi_all([1:900],:));
[m1,n1]=size(csi_filter);
csi_plot_filter= fftshift(csi_filter,2);

csi_phase = angle(squeeze(csi_plot));
csi_phase_filter = angle(squeeze(csi_plot_filter));

for i=1:m
    csi_phase(i,:)=unwrap(csi_phase(i,:));
end
for i=1:m1
    csi_phase(i,:)=unwrap(csi_phase(i,:));
    csi_phase_filter(i,:)=unwrap(csi_phase_filter(i,:));
end


for k = 1:1000
    figure(13)
    hold on
    plot(csi_phase(3*(k-1)+1,:));
    figure(14)
    hold on
    plot(csi_phase_filter(3*(k-1)+1,:));
end