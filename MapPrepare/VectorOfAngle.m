function [Vector]=VectorOfAngle(Angle)
Vector=[cos(Angle*pi/180),sin(Angle*pi/180)];
Vector=Vector/norm(Vector);