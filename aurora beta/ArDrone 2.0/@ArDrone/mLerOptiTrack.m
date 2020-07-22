function mLerOptiTrack(obj,opt,id)

obj.pPos.Xopta = obj.pPos.Xopt;

if strcmp(opt.Status,'Ready')
    
    % Realiza o teste se a rotina já foi executada, caso positivo, ela irá
    % salvar os dados lidos através da mSalvarDados
    if obj.pflag.SalvarXopt == 0
        obj.pflag.SalvarXopt = 1;
    end
    
    if obj.pflag.XoptOffset == 0
        obj.pflag.XoptOffset = 1;
        disp('Calibrando OptiTrack....')
        mLerOptiTrackOffset(obj,opt,id);
    end
    rb = opt.RigidBody(id);
    
    R = [0 0 1; 1 0 0; 0 1 0];
    if ~isempty(rb.Position)
        obj.pPos.Xopt(1:3) = R*rb.Position/1000;
        
        q = quaternion(rb.Quaternion(2),...
            rb.Quaternion(3),...
            rb.Quaternion(4),...
            rb.Quaternion(1));
        qRot = quaternion( 0, 0, 0, 1);     % rotate pitch 180 to avoid 180/-180 flip for nicer graphing
        q = mtimes(q, qRot);
        angles = EulerAngles(q,'zxy');
        ang(1) =  angles(2);   % must invert due to 180 flip above
        ang(2) =  angles(1);
        ang(3) = -angles(3);   % must invert due to 180 flip above
        
        
        obj.pPos.Xopt(4:6) = ang;
        % qt = opt.RigidBody.Quaternion;
        % % 'ZYX', 'ZYZ', 'ZXY', 'ZXZ',
        % % 'YXZ', 'YXY', 'YZX', 'YZY', 'XYZ', 'XYX', 'XZY', and 'XZX'.
        % [r1 r2 r3] = quat2angle(qt,'zxy');
        %
        % ang = [r1 r2 r3]*180/pi
    end
end
%[obj.pPos.Xopt(4) obj.pPos.Xopt(5) obj.pPos.Xopt(6)]