% %%%%%%%%%%%%%%%%%%%%%%%%%Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DatabaseVideoPath='G:\SURF Features\Day.wmv';
RealTimeVideoPath='G:\SURF Features\Night.wmv';
ImageSize=64;   %reduced image size
ComparisonsPerPair=3;       % 3 bits generated for each cell-pair comparison, 5 incase of ELDB2. 
SelectedComparisonsNum=1000;       % number of randomly selected cell-pairs per sub-image (each frame is divided to 4 sub-images).
FrameCropStart=7; %Verticl crop start point.
FrameCropEnd=172; %Verticl crop end point.
P_MLDB=@ELDB1;
LDBLevels=15;
LDBMode=1; 
load GroundTruth_CBD;  % groundtruth quary/database equivelant frames, to compare our results with it.
load('MapPoints_CBD.mat');
load PropagationMatrixes_CBD;%load Propoagation matrix.
MapScale=1; %1.43;   % 1 meter =1.43 map-unit-length
PropagationErrorCovariance=[0.05;0.9;0.05];  %Propagation error covariance.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[RegionsMat,ComparisonVector]=SelectCellPairs(SelectedComparisonsNum,ImageSize,LDBLevels,LDBMode); %randomly select cell-pairs
RegionsMat=round(RegionsMat);

% Linear ELDB/MF
P_MLDB=@ELDB1;
VehicleLocalize;
figure;plot(CurrentImage);hold on
plot(GT(:,2),GT(:,1));
title(Result2D);grid

%LDB
% P_MLDB=@LDB;
% VehicleLocalize;
% figure;plot(CurrentImage);hold on
% plot(GT(:,2),GT(:,1));
% title(Result2D);grid
% 
