function mDrive(obj, speed)
% Controls the robot movement directly using motor speeds
fvel = typecast(single(speed(1)/2), 'int32');
lvel = typecast(single(speed(2)/2), 'int32');
uvel = typecast(single(speed(3)/2), 'int32');
rvel = typecast(single(speed(4)/2), 'int32');
fvel_str = strcat(num2str(fvel),',');
lvel_str = strcat(num2str(lvel),',');
uvel_str = strcat(num2str(uvel),',');
rvel_str = num2str(rvel);
obj.mCommand('PCMD',strcat('1,',  lvel_str,  fvel_str,  uvel_str,  rvel_str))
end