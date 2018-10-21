function [Difference]=AngleDiff(AngleA,AngleB)
Difference= AngleA-AngleB;
if Difference < 0
    Difference=Difference+360;
elseif Difference > 360
    Difference=Difference-360;
end