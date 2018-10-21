function [OutputDistripution]=DistriputionPropagation2D(PropagationErrorDistripution,InputDistripution,RelativeSpeedStep,PropagationMatrix)
InputSize=size(InputDistripution,1);
LeftPadding=[];
RightPadding=[];
OutputStartPointer=2;
if RelativeSpeedStep>0
    LeftPadding=zeros(RelativeSpeedStep,1);
elseif RelativeSpeedStep<0
    RightPadding=zeros(-1*RelativeSpeedStep,1);
    OutputStartPointer=2-RelativeSpeedStep;
end
InputDistripution(1932)=InputDistripution(3641-(RelativeSpeedStep-1));
InputDistripution(315)=InputDistripution(3129-(RelativeSpeedStep-1));
InputDistripution(1)=InputDistripution(1714-(RelativeSpeedStep-1));
InputDistripution(1067)=InputDistripution(3545-(RelativeSpeedStep-1));
U=[LeftPadding;PropagationErrorDistripution;RightPadding];
OutputDistripution=conv(U,InputDistripution);
OutputDistripution=OutputDistripution(OutputStartPointer:InputSize+OutputStartPointer-1,1);

BranchIndexes=find(PropagationMatrix(:,2)>0);
for i=1:size(BranchIndexes,1)
    BranchA=PropagationMatrix(BranchIndexes(i,1),1);
    BranchB=PropagationMatrix(BranchIndexes(i,1),2);
    MaxPropability=max(OutputDistripution(BranchA,1),OutputDistripution(BranchB,1));
    OutputDistripution(BranchA,1)=MaxPropability/2;
    OutputDistripution(BranchB,1)=MaxPropability/2;
end