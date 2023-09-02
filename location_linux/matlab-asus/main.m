clear
tic

ph_diff12 = load('mat_files/ph_diff12.mat');
ph_diff23 = load('mat_files/ph_diff23.mat');
    
ph_diff12 = ph_diff12.ph_diff12;
ph_diff23 = ph_diff23.ph_diff23;

% filename='data/1114/csidata_4ant_1114_1442_cali_1.pcap';%135/196

date = 1117;
for num = 1:10
for k = 1:4
% filename = strcat('raw_csi2/csidata_4ant_', num2str(date), '_AP', num2str(k), '_2.pcap');%142/223
filename = strcat('data/AP_192.168.50.', num2str(k), '_teat_final','.pcap');
csi_all = read_file(filename);
csi_all = csi_all([30*(num-1)+31:30*(num-1)+60],:);

csi_plot1 = fftshift(csi_all,2);
csi_index1=csi_phase_filter(csi_plot1);
csi_index = reshape(csi_index1.',[],1);

csi_plot = csi_plot1([csi_index],:);
csi_phase = angle(squeeze(csi_plot));

AOATOF=superMUSIC(csi_plot);

[l1,l2] = size(AOATOF);

DirectAOA=AOATOF(1,3);
mintof=AOATOF(1,2);
for i=1:l1
    if mintof>=AOATOF(i,2)
        mintof=AOATOF(i,2);
        DirectAOA=AOATOF(i,3);
    else
        mintof=mintof;
        DirectAOA=DirectAOA;
    end
end
aoa(k) =  DirectAOA;



end


AP_location = [0, 8; 8, 8; 8, 0; 0, 0];
AP_orientation_sign = [0 -1 1 1; 1 0 -1 1; -1 1 0 -1; -1 -1 1 0];
AP_orientation_offset = [0 45 0 45; 45 0 45 0; 0 45 0 45; 45 0 45 0];
AoA_flip_borderline = [0 45 0 -45; 0 0 45 0; 0 0 0 45; 0 0 0 0];
AoAs = aoa;
number_of_APs = length(AP_location);
candidate_locations = [];
for i = 1:number_of_APs - 1
    for j = i + 1:number_of_APs
        id_1 = i;
        id_2 = j;
        AoA_1 = abs(AoAs(id_1) * AP_orientation_sign(id_1, id_2) + AP_orientation_offset(id_1, id_2));
        AoA_2 = abs(AoAs(id_2) * AP_orientation_sign(id_2, id_1) + AP_orientation_offset(id_2, id_1));
        [x_1, y_1, x_2, y_2] = calculate_target_location(AP_location(id_1, 1), AP_location(id_1, 2), AP_location(id_2, 1), AP_location(id_2, 2), AoA_1, AoA_2);
        if (AoAs(id_1) < AoA_flip_borderline(id_1, id_2))
            candidate_locations = [candidate_locations; x_2, y_2];
        else
            candidate_locations = [candidate_locations; x_1, y_1];
        end
    end
end


figure(32)
x = mean(candidate_locations([1,3,4,6], 1))
y = mean(candidate_locations([1,3,4,6], 2))
% hold on
% scatter(1.6, 4,200,'b');
hold on
scatter(x, y,100,'r');
axis([0, 8, 0, 8]);
toc
end
saveas(gcf,'s.jpg');