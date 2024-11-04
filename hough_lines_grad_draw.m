function hough_lines_grad_draw(img, outfile, peaks, rho, theta, votes)
    imshow(img);
    hold on;

    for i = 1:size(peaks, 1)
        peak_index = peaks(i, :);
        rho_max = rho(peak_index(1));
        theta_max = theta(peak_index(2));
        pixel_values = votes{peak_index(1), peak_index(2)};
        if isempty(pixel_values)
            continue;
        end
        plot(pixel_values(:, 1), pixel_values(:, 2), 'g', 'LineWidth', 2);
    end
    hold off;
    title('Detected Line Segments');
    saveas(gcf, outfile);
end
