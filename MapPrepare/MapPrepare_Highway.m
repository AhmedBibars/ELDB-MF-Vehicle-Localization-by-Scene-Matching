% Compute Distance matrix
load MapPoints_Highway;
DatabasePintsNum=size(MapPoints,1);
DistanceMatrix=zeros(DatabasePintsNum,DatabasePintsNum,'single');
for i=1:DatabasePintsNum
    for j=1:DatabasePintsNum
        DistanceMatrix(i,j)=sum((MapPoints(i,:)-MapPoints(j,:)).^2,2);
    end
end
DistanceMatrix=sqrt(DistanceMatrix);
save('Highway_DistanceMatrix.mat','DistanceMatrix');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load Highway_DistanceMatrix; load MapPoints_Highway;
Covariance=[0.05,0.9,0.05];
DBFramesNum=size(DistanceMatrix,1);
PropagationStep=1;
DistanceMatrix_1=DistanceMatrix./PropagationStep;
DistanceMatrix_1=round(DistanceMatrix_1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MaxEffectiveDistance=ceil(size(Covariance,2)/2);
for FramesCounter=1:DBFramesNum
    Out=[];%FramesCounter; Impact=Covariance(1,1);
    Impact=[];
    NearPoints=find(DistanceMatrix_1(FramesCounter,:)<=MaxEffectiveDistance);  %<=
    for NearPointsCounter=1:size(NearPoints,2)
        DisplacmentVector=MapPoints(FramesCounter,:)-MapPoints(NearPoints(1,NearPointsCounter),:);
        NearPointHeading=MapVectors(NearPoints(1,NearPointsCounter),:);
        DotProduct=dot(DisplacmentVector,NearPointHeading);
        if DotProduct>=0
            AddedPoint=NearPoints(1,NearPointsCounter);
            Out=[Out,AddedPoint];
            Impact=[Impact,Covariance(DistanceMatrix_1(FramesCounter,AddedPoint)+1)];
        end
    end
    PropagationMatrix(FramesCounter,1:size(Out,2))=Out;
    ImpactMatrix(FramesCounter,1:size(Impact,2))=Impact;
end
save('PropagationMatrixes_Highway.mat','PropagationMatrix','ImpactMatrix');