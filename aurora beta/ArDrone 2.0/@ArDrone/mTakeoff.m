function mTakeoff(obj)
obj.mCommand('FTRIM','')
obj.mCommand('CONFIG','\"control:altitude_max\", \"20000\"')
obj.mCommand('REF','290718208')
end