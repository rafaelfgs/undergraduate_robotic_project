function mCommand(obj, command_type, code)
AR_CMD = sprintf( 'AT*%s=%i,%s\r', command_type, obj.pUDP.seq, code);
fprintf(obj.pUDP.ARc, AR_CMD);
obj.pUDP.seq = obj.pUDP.seq + 1;
end