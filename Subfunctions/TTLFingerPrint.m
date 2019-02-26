function [TimeStamps,nPulses] = TTLFingerPrint(nBlock,nPulsesEach)
%TTLFINGERPRINT Send TTL pulses in a random manner to make a fingerprint of
%each block.
%   Input:
%        - nBlock: the number of blocks of TTL pulses you want to send.
%                  In this function, each block will send certain number of
%                  pulses within 2 seconds in a randomly in time.
%        - nPulsesEach: Define the number of pulses in each pulse block
%   Output:
%        - Send TTL pulses to the trigger channel according to your
%        parameters.
%        - nPulses: the total pulses sent.
%        - TimeStamps: return the timestamps of each pulses
%
% This function is meant to be put before the after the stimuli events to
% guarantee the completeness and uniqueness of the iEEG data.
% Baotian Zhao 20181219@ Beijing Tiantan Hospital
% 
% 20181228 update: Decrease the time interval of each pulses in each block

nPulses = nBlock * nPulsesEach;
% Create random inter-trial interval
nRandomNumber = nPulsesEach - 1;

% RandMatrixITI = 0.5 + rand(nBlock,nRandomNumber)*0.5;
RandMatrixITI = 0.2 + rand(nBlock,nRandomNumber)*0.2;



TimeStamps = zeros(nBlock,nPulsesEach);

RTBox('clear');
for i = 1:nBlock
    for j = 1:nPulsesEach
        TimeStamps(i,j) = RTBox('TTL', 128);
        if j < nPulsesEach
            pause(RandMatrixITI(i,j)) % pause randomly between 0.5s to 1s between TTL pulses within each block
        end
    end
    pause(2); % Pause 2 seconds between blocks   
end

end
