%This file generateds two matrixes (PropagationMatrix,ImpactMatrix) for a
%specific "PropagationErrorCovariance". The generated matrixes are used to
%conduct a fast propagation, using matrix multiplication, instead of 
%conductiong the propagation by convolute probalility vector with the 
%"PropagationErrorCovariance".

clear;
% Compute Distance matrix (distance between every two points)
load MapPoints_CBD;
DatabasePintsNum=size(MapPoints,1);
DistanceMatrix=zeros(DatabasePintsNum,DatabasePintsNum,'single');
for i=1:DatabasePintsNum
    for j=1:DatabasePintsNum
        DistanceMatrix(i,j)=sum((MapPoints(i,:)-MapPoints(j,:)).^2,2);
    end
end
DistanceMatrix=sqrt(DistanceMatrix);
%save('CBD_DistanceMatrix.mat','DistanceMatrix');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load MapPoints_CBD; %load CBD_DistanceMatrix;
PropagationErrorCovariance=[0.05,0.9,0.05];%-------------------------------------------->
DBFramesNum=size(DistanceMatrix,1);
PropagationStep=1.43;
DistanceMatrix_1=DistanceMatrix./PropagationStep;
DistanceMatrix_1=round(DistanceMatrix_1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MaxEffectiveDistance=ceil(size(PropagationErrorCovariance,2)/2);
for FramesCounter=1:DBFramesNum
    Out=[];
    Impact=[];
    NearPoints=find(DistanceMatrix_1(FramesCounter,:)<=MaxEffectiveDistance);% near points that affects the probaility of the current location
    for NearPointsCounter=1:size(NearPoints,2)
        DisplacmentVector=MapPoints(FramesCounter,:)-MapPoints(NearPoints(1,NearPointsCounter),:);%Vector from the near-point to current location
        NearPointHeading=MapVectors(NearPoints(1,NearPointsCounter),:);
        DotProduct=dot(DisplacmentVector,NearPointHeading);% is +ve if the near-point is behind the current point.
        if DotProduct>=0   %point is behind the current location
            AddedPoint=NearPoints(1,NearPointsCounter);
            Out=[Out,AddedPoint];
            Impact=[Impact,PropagationErrorCovariance(MaxEffectiveDistance-DistanceMatrix_1(FramesCounter,AddedPoint)+1)];
        elseif DistanceMatrix_1(FramesCounter,NearPoints(NearPointsCounter))<=MaxEffectiveDistance-2  % if the point is after the current location and still in the range of the covariance matrix
            AddedPoint=NearPoints(1,NearPointsCounter);
            Out=[Out,AddedPoint];
            Impact=[Impact,PropagationErrorCovariance(MaxEffectiveDistance+DistanceMatrix_1(FramesCounter,AddedPoint)+1)];
        end
    end
    PropagationMatrix(FramesCounter,1:size(Out,2))=Out;
    ImpactMatrix(FramesCounter,1:size(Impact,2))=Impact;
end
save('PropagationMatrixes_CBD.mat','PropagationMatrix','ImpactMatrix');