% %%%%%%%%%%%%%%%%%%%%%%%%%Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DatabaseVideoPath='G:\Binary Surf Highway\Night.wmv';
RealTimeVideoPath='G:\Binary Surf Highway\Day.wmv';
ImageSize=64;   %reduced image size
ComparisonsPerPair=3;       % 3 bits generated for each cell-pair comparison, 5 incase of ELDB2. 
SelectedComparisonsNum=1000;       % number of randomly selected cell-pairs per sub-image (each frame is divided to 4 sub-images).
FrameCropStart=33; %Verticl crop start point.
FrameCropEnd=172; %Verticl crop end point.
P_MLDB=@ELDB1;
LDBLevels=15;
LDBMode=1; 
load GroundTruth_Highway;  % groundtruth quary/database equivelant frames, to compare our results with it.
load('MapPoints_Highway.mat');
load PropagationMatrixes_Highway;%load Propoagation matrix.
MapScale=1;   % 1 meter =2 map-unit-length
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
