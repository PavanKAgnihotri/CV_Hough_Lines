function peaks = hough_peak (H, varargin)

    % Find peaks in a Hough accumulator array.
    %
    % Matlab documentation for houghpeaks(), which you are simulating:
    % http://www.mathworks.com/help/images/ref/houghpeaks.html
    %
    % Params:
    % H: accumulator array (nRho x nTheta)
    % Threshold (opt): Threshold at which vals of H are considered to be peaks
    % NHoodSize (optional): Size of the suppression neighborhood, [M N]
    %
    % Returns:
    % peaks: Qx2 matrix:
    % col 1 = row indices of maxima (rho);
    % col 2 = col indices of maxima (theta)

    % --------------------------------------------------------------------------

    %% Parse input arguments
    p = inputParser;
    addOptional (p, 'numpeaks', 1, @isnumeric);
    addParameter(p, 'Threshold', 0.5 * max(H(:)));
    addParameter(p, 'NHoodSize', floor(size(H) / 100.0) * 2 + 1);
                                                      % odd values >= size(H)/50
    parse(p, varargin{:});

    numpeaks  = p.Results.numpeaks;
    threshold = p.Results.Threshold;
    nHoodSize = p.Results.NHoodSize;

    % --------------------------------------------------------------------------
    % TODO: Your code here

    peaks = [];
    H_padarr = padarray(H, floor(nHoodSize/2), 0, 'both');

    for i = 1:numpeaks
        [max_val, max_index] = max(H_padarr(:));
        
        if max_val < threshold
            break;
        end

        [row, col] = ind2sub(size(H_padarr), max_index);

        rho_idx = row - floor(nHoodSize(1)/2);
        theta_idx = col - floor(nHoodSize(2)/2);

        peaks = [peaks; rho_idx, theta_idx];

        row_begin = max(row - floor(nHoodSize(1)/2), 1);
        row_end = min(row + floor(nHoodSize(1)/2), size(H_padarr, 1)); 
        col_begin = max(col - floor(nHoodSize(2)/2), 1);
        col_end = min(col + floor(nHoodSize(2)/2), size(H_padarr, 2)); 

        H_padarr(row_begin:row_end, col_begin:col_end) = 0;
    end
end
