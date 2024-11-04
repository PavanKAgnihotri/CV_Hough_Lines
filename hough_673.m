% structure for Hough homework
%% -----------------------------------------------------------------------------
%edge detection

img = imread(fullfile('input', 'square2x2.png'));
%% TODO: compute edge image img_edges
img_edges = edge(img, 'canny');
imwrite(img_edges, fullfile('output', 'square_edges.png'));

figure, imshow (img_edges), title ('edges')

fprintf('Program paused. Press enter to continue.\n');
pause;

%% -----------------------------------------------------------------------------
% accumulator array

[H, theta, rho] = hough_lines_acc (img_edges); % see `hough_lines_acc.m`
% TODO: build H_img, an image of your accumulator array (Matlab has a function)

H_img = mat2gray(H);
H_img = im2uint8(H_img);
imwrite (H_img, fullfile ('output', 'square_acc.png'));

figure, imshow (H_img), title ('accumulator array')
fprintf('Program paused. Press enter to continue.\n');
pause;

%% -----------------------------------------------------------------------------
% peaks

peaks = hough_peaks(H, 10); 
disp('Detected peaks');
disp(peaks);% see associated fn
draw_highlighted_peaks (H_img, peaks, theta, rho);           % see associated fn
print (fullfile ('output', 'square_peaks.png'),'-dpng'); % outputs displayed img

fprintf('Program paused. Press enter to continue.\n');
pause;

%% -----------------------------------------------------------------------------
% lines
figure;
hough_lines_draw (img, fullfile('output', 'square_lines.png'),peaks,rho,theta);

fprintf('Program paused. Press enter to continue.\n');
pause;

% -----------------------------------------------------------------------------
% this completes Part 1
% ADD CODE FOR PARTS 2 and 3 HERE, MIMICKING THE ABOVE CODE 
% BUT WITH ADDITIONAL PREPROCESSING AND DIFFERENT INPUT/OUTPUT;
% OUTPUT EACH STAGE AS ABOVE TO RELEVANT IMAGES
% Part 2: noisy_edge.png, noisy_acc.png, ...
% Part 3: real_edge.png, real_acc.png, ...
% 
% to get you started:

img = imread (fullfile ('input', 'noisy_square2x2.png'));
% REST OF PART 2
img_smooth = imgaussfilt(img, 5);
img_edges = edge(img_smooth, 'canny');
imwrite(img_edges, fullfile('output', 'noisy_edge.png'));

figure, imshow (img_edges), title ('edges')

fprintf('Program paused. Press enter to continue.\n');
pause;

[H, theta, rho] = hough_lines_acc (img_edges,'RhoResolution',2, 'ThetaResolution',1);
H_img = mat2gray(H);
H_img = im2uint8(H_img);
imwrite (H_img, fullfile ('output', 'noisy_acc.png'));
figure, imshow (H_img), title ('accumulator array')
fprintf('Program paused. Press enter to continue.\n');
pause;

peaks = hough_peaks(H, 10); 
disp('Detected peaks');
disp(peaks);
draw_highlighted_peaks (H_img, peaks, theta, rho);           
print (fullfile ('output', 'noise_peaks.png'),'-dpng'); 

fprintf('Program paused. Press enter to continue.\n');
pause;

figure;
hough_lines_draw (img, fullfile('output', 'noise_lines.png'),peaks,rho,theta);

fprintf('Program paused. Press enter to continue.\n');
pause;

%-------------------------------------------------------------------------
img = imread (fullfile ('input', 'real_image.png'));

% REST OF PART 3
img_gray = rgb2gray(img);
img_smooth = imgaussfilt(img_gray, 10);
img_edges = edge(img_smooth, 'canny');
imwrite(img_edges, fullfile('output', 'real_edge.png'));

figure, imshow (img_edges), title ('edges')

fprintf('Program paused. Press enter to continue.\n');
pause;

[H, theta, rho] = hough_lines_acc (img_edges, 'RhoResolution', 2.2, 'ThetaResolution', 2.7);
H_img = mat2gray(H);
H_img = im2uint8(H_img);
imwrite (H_img, fullfile ('output', 'real_acc.png'));
figure, imshow (H_img), title ('accumulator array')
fprintf('Program paused. Press enter to continue.\n');
pause;

peaks = hough_peaks(H, 10); 
disp('Detected peaks');
disp(peaks);
draw_highlighted_peaks (H_img, peaks, theta, rho);           % see associated fn
print (fullfile ('output', 'real_peaks.png'),'-dpng'); % outputs displayed img

fprintf('Program paused. Press enter to continue.\n');
pause;

figure;
hough_lines_draw (img, fullfile('output', 'real_lines.png'),peaks,rho,theta);

fprintf('Program paused. Press enter to continue.\n');
pause;

%-----------------------------------------------------
% TESTING IMAGES
%-----------------------------------------------------

img = imread (fullfile ('input', 'mosaic.jpg'));

max_dimentions = 500;
if size(img,1) >max_dimentions || size(img,2) > max_dimentions
    img = imresize(img, [max_dimentions NaN]);
end
img_gray = rgb2gray(img);
img_smooth = imgaussfilt(img_gray, 2);
img_edges = edge(img_smooth, 'canny');
imwrite(img_edges, fullfile('output', 'test_edge.png'));

figure, imshow (img_edges), title ('edges')

fprintf('Program paused. Press enter to continue.\n');
pause;

[H, theta, rho] = hough_lines_acc (img_edges, 'RhoResolution', 1.2, 'ThetaResolution', 0.1);
H_img = mat2gray(H);
H_img = im2uint8(H_img);
imwrite (H_img, fullfile ('output', 'test_acc.png'));
figure, imshow (H_img), title ('accumulator array')
fprintf('Program paused. Press enter to continue.\n');
pause;

peaks = hough_peaks(H, 10, 'Threshold', 0.4 * max(H(:)), 'NHoodSize', floor(size(H) / 100.0) * 2 + 1); 
disp('Detected peaks');
disp(peaks);
draw_highlighted_peaks (H_img, peaks, theta, rho);           
print (fullfile ('output', 'test_peaks.png'),'-dpng'); 

fprintf('Program paused. Press enter to continue.\n');
pause;

figure;
hough_lines_draw (img, fullfile('output', 'test_lines.png'),peaks,rho,theta);

fprintf('Program paused. Press enter to continue.\n');
pause;

%--------------------------------------------
%building canny, sigma  = 2, numpeaks = 40, threshold= 0.4 * max(H(:)), 'RhoResolution', 1.5, 'ThetaResolution', 0.01
%--------------------------------------------
%parallel_lines canny, sigma = 2, 'NHoodSize', floor(size(H) / 50.0) * 2 + 1, 'Threshold' = 0.3 * max(H(:)), numpeaks = 10,'RhoResolution', 1, 'ThetaResolution', 0.5 
%--------------------------------------------
%mosaic numpeaks = 10, canny, sigma = 2, 'Threshold', 0.4 * max(H(:)) 'RhoResolution', 1.2, 'ThetaResolution', 0.1
%--------------------------------------------

%--------------------------------------------
%BONUS
%--------------------------------------------
% Bonus: for bonus I have changed the hough_lines_acc function for
% gradient and saved as hough_lines_grad_acc function and hough_lines_draw
% to hough_lines_grad_draw to create line segments using gradient.
%--------------------------------------------
%Part1
%--------------------------------------------
img = imread(fullfile('input', 'square2x2.png'));
img_edges = edge(img, 'canny');
imwrite(img_edges, fullfile('output', 'square_edges_bonus.png'));

figure, imshow(img_edges), title('Edges');
fprintf('Program paused. Press enter to continue.\n');
pause;

[H, theta, rho, pixelVotes] = hough_lines_grad_acc(img_edges);

H_img = mat2gray(H);
H_img = im2uint8(H_img);
imwrite(H_img, fullfile('output', 'square_acc_bonus.png'));

figure, imshow(H_img), title('Accumulator Array');
fprintf('Program paused. Press enter to continue.\n');
pause;

peaks = hough_peaks(H, 10);
disp('Detected peaks');
disp(peaks);
draw_highlighted_peaks(H_img, peaks, theta, rho);
print(fullfile('output', 'square_peaks_bonus.png'), '-dpng');

fprintf('Program paused. Press enter to continue.\n');
pause;

figure;
hough_lines_grad_draw(img, fullfile('output', 'square_lines_bonus.png'), peaks, rho, theta, pixelVotes);

fprintf('Program paused. Press enter to continue.\n');
pause;

%--------------------------------------------
%Part2
%--------------------------------------------
img = imread(fullfile('input', 'noisy_square2x2.png'));
img_smooth = imgaussfilt(img, 6);  
img_edges = edge(img_smooth, 'canny');  
imwrite(img_edges, fullfile('output', 'noisy_edge_bonus.png'));

figure, imshow(img_edges), title('Edges');

fprintf('Program paused. Press enter to continue.\n');
pause;

[H, theta, rho, pixelVotes] = hough_lines_grad_acc(img_edges, 'RhoResolution', 1.5, 'ThetaResolution', 5);

H_img = mat2gray(H);
H_img = im2uint8(H_img);
imwrite(H_img, fullfile('output', 'noisy_acc_bonus.png'));

figure, imshow(H_img), title('Accumulator Array');
fprintf('Program paused. Press enter to continue.\n');
pause;

peaks = hough_peaks(H, 10, 'Threshold', 0.25 * max(H(:)));
disp('Detected peaks:');
disp(peaks);
draw_highlighted_peaks(H_img, peaks, theta, rho); 
print(fullfile('output', 'noisy_peaks_bonus.png'), '-dpng'); 

fprintf('Program paused. Press enter to continue.\n');
pause;

figure;
hough_lines_grad_draw(img, fullfile('output', 'noisy_lines.png'), peaks, rho, theta, pixelVotes);
fprintf('Program paused. Press enter to continue.\n');
pause;

%--------------------------------------------
%Part3
%--------------------------------------------

img = imread (fullfile ('input', 'real_image.png'));
img_gray = rgb2gray(img);
img_smooth = imgaussfilt(img_gray, 10);
img_edges = edge(img_smooth, 'canny');
imwrite(img_edges, fullfile('output', 'real_edge_bonus.png'));

figure, imshow (img_edges), title ('edges')

fprintf('Program paused. Press enter to continue.\n');
pause;


[H, theta, rho, pixelVotes] = hough_lines_grad_acc (img_edges, 'RhoResolution', 2.2, 'ThetaResolution', 2.7);
H_img = mat2gray(H);
H_img = im2uint8(H_img);
imwrite (H_img, fullfile ('output', 'real_acc.png'));
figure, imshow (H_img), title ('accumulator array')
fprintf('Program paused. Press enter to continue.\n');
pause;

peaks = hough_peaks(H, 10); 
disp('Detected peaks');
disp(peaks);
draw_highlighted_peaks (H_img, peaks, theta, rho);           
print (fullfile ('output', 'real_peaks_bonus.png'),'-dpng');

fprintf('Program paused. Press enter to continue.\n');
pause;

figure;
hough_lines_grad_draw (img, fullfile('output', 'real_lines_bonus.png'),peaks,rho,theta, pixelVotes);

fprintf('Program paused. Press enter to continue.\n');
pause;

%--------------------------------------------