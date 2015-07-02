function [ A ] = rotate( axis,deg )

if axis == 1    %% x
    A = [1,0,0;0,cos(deg),-sin(deg);0,sin(deg),cos(deg)];
elseif axis == 2    %% y
    A = [cos(deg),0,sin(deg);0,1,0;-sin(deg),0,cos(deg)];
elseif axis == 3    %% z
    A = [cos(deg),-sin(deg),0;sin(deg),cos(deg),0,0;0,0,1,0;0,0,0,1];
end

end

