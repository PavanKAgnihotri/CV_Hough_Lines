function [H, theta, rho] = hough_lines_acc (BW, varargin)

    % Build Hough accumulator array for finding lines.
    %
    % Matlab documentation for hough(), which you are simulating:
    % http://www.mathworks.com/help/images/ref/hough.html
    %
    % Coordinate system of H
    % rows of H correspond to values of rho
    % cols of H correspond to values of theta
    %
    % Params:
    % BW: Binary (black and white) image containing edge pixels
    % RhoResolution (optional): diff between successive rho values, in pixels
    % ThetaResolution (optional): diff between successive theta values, in deg
    % 
    % 
    % Returns:
    % H: accumulator array (nRho x nTheta)
    % theta: angle values, correspond to columns of H [so our binning choice]
    % rho: distance values, correspond to rows of H

    % --------------------------------------------------------------------------
    % Parse input arguments 
    % (you have not seen optional arguments before: observe how it is done)
    p = inputParser();
    addParameter (p, 'RhoResolution', 1);               % add with default value
    addParameter (p, 'ThetaResolution', 1);
    parse (p, varargin{:});                               % [populate p.Results]
    rhoStep   = p.Results.RhoResolution;
    thetaStep = p.Results.ThetaResolution;
    % --------------------------------------------------------------------------
    %% ADD YOUR CODE HERE
    [rows, cols] = size(BW);
    theta = -90:thetaStep:90;
    thetaradience = deg2rad(theta);

    diagonal_len = sqrt(rows^2 + cols^2);
    maxrho = ceil(diagonal_len);
    rho = -maxrho:rhoStep:maxrho;

    H = zeros(length(rho), length(theta));
    [y_index, x_index] = find(BW);

    for i = 1:length(x_index)
        x = x_index(i);
        y = y_index(i);
        
        for j  = 1:length(thetaradience)
            %rho = x*cos(theta) + y*Sin(theta)
            rho_value = x * cos(thetaradience(j)) + y * sin(thetaradience(j));
            rho_index = round((rho_value - rho(1))/rhoStep) + 1;
            H(rho_index, j) = H(rho_index, j) + 1;
        end
    end    
end
