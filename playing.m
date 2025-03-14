%% info = ncinfo("C:\Users\axelle.piguet\Documents\GitHub\klab_analysis\Axelle\nk49\result\C.nc");
% C = ncread("C:\Users\axelle.piguet\Documents\GitHub\klab_analysis\Axelle\nk49\result\C.nc", 'C');

info = ncinfo("\\iss\karalis\users\axelle.piguet\C.nc");
C = ncread("\\iss\karalis\users\axelle.piguet\C.nc", 'C');
%this is nk50 session 2

%% calcium traces 
figure;
hold on;
i = 0 
nb_unit = size(C,2)

for idx = 1:nb_unit 
    i = i+1
    color = 'r'
    if mod(i, 2) == 0 
        color = 'm'
    end
    plot(C(:,idx) - 10*i, color)
end
%% raster
% fig, ax = plt.subplots()
% fig.figsize=(7, 15)
% im = ax.imshow(S, aspect = 'auto', cmap = 'binary')
% plt.xlabel('Time')
% plt.ylabel('Units')
% plt.gca().spines['top'].set_visible(False)  # Hides the top spine
% plt.gca().spines['right'].set_visible(False)  # Hides the right spine
% plt.gca().xaxis.set_ticks([])
% plt.gca().set_xticklabels([])

% Raster plot
info = ncinfo("\\iss\karalis\users\axelle.piguet\S.nc");
S = ncread("\\iss\karalis\users\axelle.piguet\S.nc", 'S');


figure;
imagesc(S'); % Display the matrix S as an image
%colormap('gray'); % Use a binary-like colormap ('gray' is the closest equivalent)
set(gca, 'YDir', 'normal'); % Ensure y-axis is oriented correctly (similar to 'aspect="auto"')

% Set figure size
set(gcf, 'Position', [100, 100, 700, 1500]); % Adjust figure size (in pixels)

% Labels
xlabel('Time');
ylabel('Units');

% Hide top and right spines (equivalent to hiding box edges)
box off; % Turns off the surrounding box
set(gca, 'XColor', 'none'); % Hides the x-axis ticks
set(gca, 'XTick', []); % Removes the x-axis ticks
set(gca, 'XTickLabel', []); % Removes the x-axis tick labels



%% CROSS REGISTRATION 
info = ncinfo("\\iss\karalis\users\axelle.piguet\S_allSessions.nc");
S_all = ncread("\\iss\karalis\users\axelle.piguet\S_allSessions.nc", 'S_all');

session_names = ncread("\\iss\karalis\users\axelle.piguet\S_allSessions.nc", 'session');

% defining numbers 
match_index = find(strcmp({info.Variables.Name}, 'S_all')); % Logical array where name == 'S_all'
length_value = info.Variables(match_index).Size;
nb_frame = length_value(1)
nb_units = length_value(2)
nb_sessions = length_value(3)

% Define colors
colormap_name= 'hsv';
num_colors = 256;       % Number of colors in the colormap (can be adjusted)
cmap = colormap(colormap_name); % Get the current colormap (256x3 matrix by default)

% Create a figure
figure;
hold on; % Enable multiple plots on the same axes
set(gcf, 'Position', [100, 100, 1000, 500]); % Adjust figure size

% Loop through sessions
for sess = 1:nb_sessions
    % Define the colormap
    random_index = randi(size(cmap, 1)); % Random row index
    random_color = cmap(random_index, :);
    random_color = [0 0 0] 
    cmapSess= [linspace(1, random_color(1), num_colors)', ...
        linspace(1, random_color(2), num_colors)', ...
        linspace(1, random_color(3), num_colors)'];; % Main color

    % Extract the data for the current session
    session_data = S_all(:, :, sess); % Adapt this line to match MATLAB data indexing
    colormap('parula');
    % Plot the image for the current session
    %sess_data = session_data(~isnan(session_data))
    imagesc([(sess-1)*nb_frame, sess*nb_frame], [0, nb_units], session_data);
    set(gca, 'YDir', 'normal'); % MATLAB has 'YDir' reversed by default

end
xline((0:nb_sessions-1)*nb_frame,'w-.',session_names)



% Set axis limits and labels
xlim([0, nb_sessions * nb_frame]);
ylim([0, nb_units]);
xlabel('Frames');
ylabel('Units');

% Hide top and right spines
set(gca, 'Box', 'off');
set(gca, 'Layer', 'top');

hold off; % End plotting

%% CROSS REGISTRATION 
info = ncinfo("\\iss\karalis\users\axelle.piguet\C_allSessions.nc");
C_all = ncread("\\iss\karalis\users\axelle.piguet\C_allSessions.nc", 'C_all');

session_names = ncread("\\iss\karalis\users\axelle.piguet\C_allSessions.nc", 'session');
units = ncread("\\iss\karalis\users\axelle.piguet\C_allSessions.nc", 'new_unitId');


% defining numbers 
match_index = find(strcmp({info.Variables.Name}, 'C_all')); % Logical array where name == 'S_all'
length_value = info.Variables(match_index).Size;
nb_frame = length_value(1)
nb_units = length_value(2)
nb_sessions = length_value(3)

% Create a figure
figure;
hold on; % Enable multiple plots on the same axes
colors = ['c', 'b']
% Loop through sessions
for sess = 1:nb_sessions  
    for idx = units
        plot((sess-1)*nb_frame: sess*nb_frame, S_all(:, idx, sess), colors(rem(sess,2)))
        set(gca, 'YDir', 'normal'); % MATLAB has 'YDir' reversed by default
    end
end
xline((0:nb_sessions-1)*nb_frame,'w-.',session_names)



% Set axis limits and labels
xlim([0, nb_sessions * nb_frame]);
ylim([0, nb_units]);
xlabel('Frames');
ylabel('Units');

% Hide top and right spines
set(gca, 'Box', 'off');
set(gca, 'Layer', 'top');

hold off; % End plotting


