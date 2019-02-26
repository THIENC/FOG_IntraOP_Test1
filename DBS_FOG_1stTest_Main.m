function DBS_FOG_1stTest_Main
% First test regarding DBS FOG patient 
% An instructive sound with a TTL pulse
clear;
ClockRandSeed;

MainFolder = 'C:\Users\THIENC\Desktop\Task_Tiantan\DBS_FOG_IntraOP_Test1';

% RT box setup
RTBox('clear',0); 

% Open RT box if hasn't   
RTBox('TTLWidth', .02);
RTBox('enable','light');

% For parameters Dialogue box

prompt = {'Enter Subject ID','nTrials Each Block','Sound Duration','Block','Fixed ITI','Random ITI'};
def={'FOG001', '40', '0.2','1','2','2'};
Answer = inputdlg(prompt, 'Experimental setup information',1,def);
[SubID, nTrialsEachBlock, SoundDuration, Block,FixedITI,RandITIScale] = deal(Answer{:});

nTrialsEachBlock = str2num(nTrialsEachBlock);
SoundDuration    = str2num(SoundDuration);
FixedITI         = str2num(FixedITI);
RandITIScale     = str2num(RandITIScale);
%% Initializing the task with TTL finger print
[TimeStampsStart,nPulsesStart] = TTLFingerPrint(1,3);
pause(2); % Pause 2 seconds after starting finger print

%% Sound with TTL trigger
% Built the sound set sound parameters
Fs = 8192;                          % Default Sampling Frequency 8192 (Hz)
Ts = 1/Fs;                          % Sampling Interval (s)
T = 0:Ts:SoundDuration;             % 0.2 Second
Frq = 438;                          % Tone Frequency; C tone = 438Hz
Y = sin(2*pi*Frq*T);                % Sine wave tone

% Randomized inter-trial interval
RandomITI = rand(nTrialsEachBlock,1)*RandITIScale;

for i = 1:nTrialsEachBlock
    RTBox('clear');
    soundsc(Y,Fs);
    RTBox('TTL', 128);
    pause(FixedITI + RandomITI(i))
end

[TimeStampsEnd,nPulsesEnd] = TTLFingerPrint(2,3);

% Save the data
cd([MainFolder,filesep,'Data']);
% cmd = ['save sodata.' subID '.' datestr(now,'dd.mm.yyyy.HH.MM') '.mat;'];
cmd = ['save sodata.' SubID '.' datestr(now,'dd.mm.yyyy.HH.MM') '.Block', Block, '.mat;'];
eval(cmd);
cd ..

fprintf('-------------Test End----------------\n')

% tic 
%     RTBox('clear');
%     soundsc(Y,Fs);
%     RTBox('TTL', 128);
% toc



