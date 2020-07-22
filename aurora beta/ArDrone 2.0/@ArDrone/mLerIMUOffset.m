function mLerIMUOffset(obj)
% Get rigid body settings

t = tic;
tc = tic;
x = [];
while toc(t)<1
    if toc(tc) > 1/30
        tc = tic;
        mLerIMU(obj);
        x = [x obj.pPos.Ximu];
    end
end
obj.pPos.Ximuo = mean(x,2);
end