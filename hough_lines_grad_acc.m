function [H, theta, rho, votes] = hough_lines_grad_acc(BW, varargin)
    p = inputParser();
    addParameter(p, 'RhoResolution', 1);
    addParameter(p, 'ThetaResolution', 1);
    parse(p, varargin{:});
    rhoStep = p.Results.RhoResolution;
    thetaStep = p.Results.ThetaResolution;

    [rows, cols] = size(BW);
    theta = -90:thetaStep:90;
    thetaradience = deg2rad(theta);

    diagonal_len = sqrt(rows^2 + cols^2);
    maxrho = ceil(diagonal_len);
    rho = -maxrho:rhoStep:maxrho;

    H = zeros(length(rho), length(theta));
    votes = cell(length(rho), length(theta));

    [Gx, Gy] = imgradientxy(BW);
    [~, Gdir] = imgradient(Gx, Gy);  
    [y_index, x_index] = find(BW); 

    for i = 1:length(x_index)
        x = x_index(i);
        y = y_index(i);
        
        for j = 1:length(thetaradience)
            rho_value = x * cos(thetaradience(j)) + y * sin(thetaradience(j));
            rho_index = round((rho_value - rho(1)) / rhoStep) + 1;

            grad_angle = mod(Gdir(y, x), 180);
            theta_angle = mod(theta(j), 180);
            angle_diff = abs(theta_angle - grad_angle);

            if angle_diff < 180
                H(rho_index, j) = H(rho_index, j) + 1;
                votes{rho_index, j} = [votes{rho_index, j}; x, y];
            end
        end
    end
end
