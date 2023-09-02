clear all;
close all;
clc

AP_location = [0, 8; 8, 8; 8, 0; 0, 0];
AP_orientation_sign = [0 -1 1 1; 1 0 -1 1; -1 1 0 -1; -1 -1 1 0];
AP_orientation_offset = [0 45 0 45; 45 0 45 0; 0 45 0 45; 45 0 45 0];
AoA_flip_borderline = [0 45 0 -45; 0 0 45 0; 0 0 0 45; 0 0 0 0];
AoAs = [-1.80000000000000,-6.30000000000000,15.3000000000000,40.5000000000000];
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

figure(31)
candidate_locations
% 
scatter(candidate_locations([1,3,4,6], 1), candidate_locations([1,3,4,6], 2),100,'b');
axis([0, 8, 0, 8]);

figure(32)
x = mean(candidate_locations([1,3,4,6], 1))
y = mean(candidate_locations([1,3,4,6], 2))
scatter(x, y,100,'b');
axis([0, 8, 0, 8]);
