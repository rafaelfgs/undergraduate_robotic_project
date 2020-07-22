function mLerOptiTrackOffset(obj,opt,id)
% Get rigid body settings

t = tic;
tc = tic;
x = [];
while toc(t)<1
    if toc(tc) > 1/30
        tc = tic;
        mLerOptiTrack(obj,opt,id);
        x = [x obj.pPos.Xopt];
    end
end
obj.pPos.Xopto = mean(x,2);
end