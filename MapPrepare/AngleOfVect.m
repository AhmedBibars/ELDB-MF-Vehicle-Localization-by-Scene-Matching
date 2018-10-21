function [Angle]= AngleOfVect(Vector)
Angle=atan(Vector(2)/Vector(1))*180/pi;
if Vector(1)>=0 && Vector(2)<0
    Angle=Angle+360;
elseif Vector(1)<0 
    Angle=Angle+180;
end

if isnan(Angle) % if the vector is [0,0]
    Angle=0;
end