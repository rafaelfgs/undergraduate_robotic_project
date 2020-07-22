function mStop(obj)
% Stop all Robot motion and close communications.
obj.mLand
fclose(obj.pUDP.ARn);
fclose(obj.pUDP.ARc);
end
