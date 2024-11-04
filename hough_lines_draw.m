function hough_lines_draw (img, outfile, peaks, rho, theta)

    % Draw the lines found in an image using Hough transform.
    % Infinite lines, rather than line segments, are fine.
    % Overlay the lines in green on top of the image.
    % Output the line image to a file.

    % Params:
    % img:     Image on top of which to draw lines
    % outfile: Output image filename to save plot as
    % peaks:   Qx2 matrix containing row/col indices of Q peaks found in accum
    % rho:     Vector of rho values, in pixels
    % theta:   Vector of theta values, in degrees 

    % ADD CODE HERE
    imshow(img);
    hold on;

    for i = 1:size(peaks, 1)
        peak_index = peaks(i, :);
        rho_max = rho(peak_index(1));
        theta_max = theta(peak_index(2));
        thetaradience = deg2rad(theta_max);
        
        if abs(theta_max) == 90
            % Vertical line, x = constant
            fimplicit(@(x, y) x - rho_max, 'g', 'LineWidth', 2);
        elseif abs(theta_max) == 0
            % Horizontal line, y = constant
            fimplicit(@(x, y) y - rho_max, 'g', 'LineWidth', 2);
        else
            % other angles rho = x*cos(theta) + y*sin(theta)
            fimplicit(@(x, y) rho_max - (x * cos(thetaradience) + y * sin(thetaradience)), 'g', 'LineWidth', 2);
        end
    end
    hold off;
    title('Detected Lines');
    saveas(gcf, outfile);
end
