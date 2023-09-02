clear all;
tic

% SubCarrInd_real=[-112:3:-11,11:3:112];


% filename = 'raw_csi/csidata_4ant_1117_AP2_4.pcap';
filename = 'raw_csi3/csidata_4ant_cali_111.pcap';
% filename = 'csidata_4ant_1116_1843.pcap';
csi_all = read_file(filename);

% csi_plot = fftshift(csi_all([3001:6000],SubCarrInd_real+129),2);
csi_plot = fftshift(csi_all([4501:5100],:),2);

% for k = 1:3000
csi_phase = angle(csi_plot);
% 
% end

% count=1;
% phase_set=[];
% for k = 1:10
%     phase_ant1(k,:) =  unwrap(csi_phase(3*(k-1)+1,:));
%     
% %     phase_ant1(k,:) = phase_ant1(k,SubCarrInd_real+129);
%     
%     figure(13)
%     hold on
%     plot(phase_ant1(k,:));
% 
% %     if legal_yy(SubCarrInd_real,phase_ant1(k,:))
% %             phase_set(count,:) = csi_phase(k,:);
% %             count=count+1;
% %      else
% %      end
% 
% end

for k = 1:200
    
phase_diff12(k,:) = mod((csi_phase(3*(k-1)+2,:) - csi_phase(3*(k-1)+1,:)),2*pi);

phase_diff23(k,:) = mod((csi_phase(3*(k-1)+2,:) - csi_phase(3*(k-1)+3,:)),2*pi);
end

% phase_diff12 = medfilt1(phase_diff12,5);  
% phase_diff23 = medfilt1(phase_diff23,5); 

for i = 1:64
    ph_diff12(i) = mean(phase_diff12(:,i));
    ph_diff23(i) = mean(phase_diff23(:,i));
end

save('mat_files/ph_diff12.mat','ph_diff12');
save('mat_files/ph_diff23.mat','ph_diff23');



figure(11)
plot(phase_diff12(:,21));

figure(12)
plot(phase_diff23(:,21));









toc
