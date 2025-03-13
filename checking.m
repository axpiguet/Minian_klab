videoPath = "\\iss\karalis\users\axelle.piguet\processedvideo.mp4"
videoReaders = VideoReader(videoPath);
C = ncread("\\iss\karalis\users\axelle.piguet\C.nc", 'C');
A = ncread("\\iss\karalis\users\axelle.piguet\A.nc", 'A');
%%

% Preallocate 3D matrix (grayscale)
videoMatrix = zeros(videoReaders.Height, videoReaders.Width,videoReaders.NumFrames, 'uint8');

% Read and store each frame
frameIdx = 1;
while hasFrame(videoReaders) && frameIdx <= videoReaders.NumFrames
    frame = readFrame(videoReaders); % Read frame
    grayFrame = rgb2gray(frame); % Convert to grayscale
    videoMatrix(:, :, frameIdx) = grayFrame; % Store in 3D matrix
    frameIdx = frameIdx + 1;
end

% Display the size of the 3D matrix
disp(size(videoMatrix));  % Should output: [Height, Width, Frames]
%%
[proj, ix] = max(A);
pixelToNumberMap = ix; 
unit_id = 56
cell_map = uint8(ceil(A(:,:,unit_id)))';
mask3D = repmat(cell_map, [1, 1, size(videoMatrix,3)]); 
calcium = C(:,unit_id);
%%
unit_focusedvideo = videoMatrix.*mask3D;
unit_light = sum(unit_focusedvideo,[1 2]);
%%
figure; 
plot(normalize(squeeze(unit_light)))
hold on 
plot( normalize(calcium))
ylim ([-1.5 8])