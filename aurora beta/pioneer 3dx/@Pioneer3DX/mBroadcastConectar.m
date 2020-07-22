function mBroadcastConectar(obj)
if isempty(obj.pID)
    obj.pID = 1;
end
obj.pUDP = udp('255.255.255.255',25000+obj.pID);
fopen(obj.pUDP);

end