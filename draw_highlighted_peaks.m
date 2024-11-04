function drawHighlightedPeaks (img, peaks, theta, rho)

  % Highlight the peak locations on accumulator array, 
  % by drawing a red circle around each peak.
  % useful Matlab fn: plot

  % Params:
  % img:   image of accumulator array
  % peaks: Qx2 matrix of peaks
  % theta: vector of angle values (in columns of accumulator array)
  % rho: vector of distance values (in rows of accumulator array)

  % ADD CODE HERE
  imagesc(theta, rho, img);
  hold on;
  for i = 1:size(peaks, 1)
      rho_peak = peaks(i, 1);    
      theta_peak = peaks(i, 2);  

      rho_val = rho(rho_peak);
      theta_val = theta(theta_peak);

      plot(theta_val, rho_val, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
  end
  hold off;
end