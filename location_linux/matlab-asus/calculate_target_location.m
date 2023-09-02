function [x_1, y_1, x_2, y_2] = calculate_target_location(AP1_x, AP1_y, AP2_x, AP2_y, angle_1, angle_2)
    vec_12 = (AP2_x - AP1_x) + 1i * (AP2_y - AP1_y);
    vec_21 = (AP1_x - AP2_x) + 1i * (AP1_y - AP2_y);
    vec_rotate_1 = cos(angle_1 * pi / 180) + 1i * sin(angle_1 * pi / 180);
    vec_rotate_2 = cos(angle_2 * pi / 180) - 1i * sin(angle_2 * pi / 180);
    vec_12 = vec_12 * vec_rotate_1;
    vec_21 = vec_21 * vec_rotate_2;
    theta_1 = angle(vec_12);
    theta_2 = angle(vec_21);
    k_1 = tan(theta_1);
    b_1 = -k_1 * AP1_x + AP1_y;
    k_2 = tan(theta_2);
    b_2 = -k_2 * AP2_x + AP2_y;
    [x, y] = calculate_intersection(k_1, b_1, k_2, b_2);
    x_1 = x;
    y_1 = y;
    vec_12 = (AP2_x - AP1_x) + 1i * (AP2_y - AP1_y);
    vec_21 = (AP1_x - AP2_x) + 1i * (AP1_y - AP2_y);
    vec_rotate_1 = cos(angle_1 * pi / 180) - 1i * sin(angle_1 * pi / 180);
    vec_rotate_2 = cos(angle_2 * pi / 180) + 1i * sin(angle_2 * pi / 180);
    vec_12 = vec_12 * vec_rotate_1;
    vec_21 = vec_21 * vec_rotate_2;
    theta_1 = angle(vec_12);
    theta_2 = angle(vec_21);
    k_1 = tan(theta_1);
    b_1 = -k_1 * AP1_x + AP1_y;
    k_2 = tan(theta_2);
    b_2 = -k_2 * AP2_x + AP2_y;
    [x, y] = calculate_intersection(k_1, b_1, k_2, b_2);
    x_2 = x;
    y_2 = y;
end

function [x, y] = calculate_intersection(k_1, b_1, k_2, b_2)
    x = (b_2 - b_1) / (k_1 - k_2);
    y = k_1 * x + b_1;
end