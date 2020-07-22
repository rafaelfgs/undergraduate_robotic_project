function mConectar(obj,IP)
if nargin < 2
    IP = 1;
end

obj.pStatus.Conectado = 1;
obj.pUDP.seq = 3;

% NavData Properties
obj.pUDP.Control_State = [];
obj.pUDP.Battery_Voltage = 0;
obj.pUDP.Pitch = 0;
obj.pUDP.Roll = 0;
obj.pUDP.Yaw = 0;
obj.pUDP.Altitude = 0;
obj.pUDP.X_Velocity = 0;
obj.pUDP.Y_Velocity = 0;
obj.pUDP.Z_Velocity = 0;
obj.pUDP.X_Acc = 0;
obj.pUDP.Y_Acc = 0;
obj.pUDP.Z_Acc = 0;
obj.pUDP.X_Gyro = 0;
obj.pUDP.Y_Gyro = 0;
obj.pUDP.Z_Gyro = 0;
obj.pUDP.NavData = 0;
obj.pUDP.Tm = 0;

instrreset

% Criar conexão UDP para controle do Drone
obj.pUDP.ARc = udp(['192.168.1.' num2str(IP)], 5556, 'LocalPort', 5556);
fopen(obj.pUDP.ARc);

% Criar conexão NavData com Drone
obj.pUDP.ARn = udp(['192.168.1.' num2str(IP)], 5554, 'LocalPort', 5554, ...
    'ByteOrder', 'littleEndian', ...
    'InputBufferSize', 500, ...
    'BytesAvailableFcn', {@navPacketRxCallback,obj}, ...
    'DatagramTerminateMode', 'on', ...
    'BytesAvailableFcnMode', 'byte', ...
    'BytesAvailableFcnCount', 24);
fopen(obj.pUDP.ARn);

% Byte para inicialização da porta NavData
fwrite(obj.pUDP.ARn, 1);

% Comando NavData para porta de comando
AR_NAV_CONFIG = sprintf('AT*CONFIG=2,\"general:navdata_demo\",\"TRUE\"\r');
fprintf(obj.pUDP.ARc, AR_NAV_CONFIG);

% Flicker LEDs
obj.mCommand('LED', '1,5,5,5,5')

    function navPacketRxCallback(objX, event, droneX)
        
        if (get(objX, 'BytesAvailable') ~= 0)
            data = fread(objX);
            data = uint8(data);
            if ~isempty(data);
                try
                    
                    % Drone Control State Information
                    drone_state = [data(5) data(6) data(7) data(8)];
                    drone_state = typecast(drone_state, 'uint32');
                    for i = 1:32
                        droneX.pUDP.Control_State(i) = bitget(drone_state, i);
                    end
                    
                    % Battery Voltage Percentage
                    vBattery = [data(25) data(26) data(27) data(28)];
                    droneX.pUDP.Battery_Voltage = typecast(vBattery, 'uint32');
                    
                    % Theta (Pitch) Values
                    tPitch = [data(29) data(30) data(31) data(32)];
                    droneX.pUDP.Pitch = typecast(tPitch, 'single') / 1000;
                    
                    % Phi (Roll) Values
                    tRoll = [data(33) data(34) data(35) data(36)];
                    droneX.pUDP.Roll = typecast(tRoll, 'single') / 1000;
                    droneX.pUDP.Roll;
                    
                    % Psi (Yaw) Values
                    tYaw = [data(37) data(38) data(39) data(40)];
                    droneX.pUDP.Yaw = typecast(tYaw, 'single') / 1000;
                    
                    % Altitude
                    tAltitude = [data(41) data(42) data(43) data(44)];
                    droneX.pUDP.Altitude = single(typecast(tAltitude, 'int32'))/ 1000;
                    
                    % X Velocity
                    Vx = [data(45) data(46) data(47) data(48)];
                    droneX.pUDP.X_Velocity = typecast(Vx, 'single') / 1000;
                    
                    % Y Velocity
                    Vy = [data(49) data(50) data(51) data(52)];
                    droneX.pUDP.Y_Velocity = typecast(Vy, 'single') / 1000;
                    
                    % Z Velocity
                    Vz = [data(53) data(54) data(55) data(56)];
                    droneX.pUDP.Z_Velocity = typecast(Vz, 'single') / 1000;   
                    
                    % X Acceleration m/s^2 
                    Xacc = data(56:60);
                    droneX.pUDP.X_Acc = typecast(Xacc, 'single') / 1000;   
                    
                    % Y Acceleration m/s^2 
                    Xacc = data(61:64);
                    droneX.pUDP.X_Acc = typecast(Xacc, 'single') / 1000;                       
                    
                    % Z Acceleration m/s^2 
                    Zacc = data(65:68);
                    droneX.pUDP.Z_Acc = typecast(Zacc, 'single') / 1000;                       
                    
                    % X Giro o/s^2 
                    Xgyro = data(69:72);
                    droneX.pUDP.X_Gyro = typecast(Xgyro, 'single') / 1000;   
                    
                    % Y Giro o/s^2
                    Ygyro = data(69:72);
                    droneX.pUDP.Y_Gyro = typecast(Ygyro, 'single') / 1000;   
                    
                    % Z Giro o/s^2
                    Zgyro = data(69:72);
                    droneX.pUDP.Z_Gyro = typecast(Zgyro, 'single') / 1000;   
                    
                    % Time Sample
                    Tm = data(73:76);
                    droneX.pUDP.Tm = typecast(Tm, 'single') / 1000;   
                    
                end
                
                % Entire NavData Packet                
                droneX.pUDP.NavData = data;
                droneX.pDados.bateria = double(droneX.pUDP.Battery_Voltage);
                droneX.pDados.SensorRaw = ...
                    [droneX.pUDP.Altitude; ...                    
                    droneX.pUDP.Roll; ...
                    droneX.pUDP.Pitch; ... 
                    droneX.pUDP.Yaw; ...                    
                    droneX.pUDP.X_Velocity; ...
                    droneX.pUDP.Y_Velocity; ...
                    droneX.pUDP.Z_Velocity; ...
                    droneX.pUDP.X_Acc; ...
                    droneX.pUDP.Y_Acc; ...
                    droneX.pUDP.Z_Acc; ...
                    droneX.pUDP.X_Gyro; ...
                    droneX.pUDP.Y_Gyro; ...
                    droneX.pUDP.Z_Gyro; ...
                    droneX.pUDP.Tm; ...
                    double(droneX.pUDP.Battery_Voltage)];
            end
            
            % Reset Drone Watchdog Bit
            AR_WDG = strcat('AT*COMWDG=',num2str(droneX.pUDP.seq),',');
            fprintf(droneX.pUDP.ARc, AR_WDG);
            droneX.pUDP.seq = droneX.pUDP.seq + 1;
        end
    end
end
