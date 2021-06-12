function song = practice1(tonic, mode, beat_dur, fs)

% tonic    = key of "song"
% mode     = 4 element array indicating music mode
%            major      = [1 5 8 12]
%            minor      = [1 4 8 11]
%            dominant   = [1 5 8 11]
%            diminished = [1 4 7 11]
% beat_dur = length of beat
% fs       = sampling frequency


alphabet = rhythmAlphabet();

X = 1;

tt = 0:(1/fs):beat_dur;

%beat_samp    = 4*ceil(fs*beat_dur);
beat_samp = 4 * length(tt);

samples_song = beat_samp*size(alphabet(12:15,:),1);

song         = zeros(1,samples_song);

n1 = 1;
for i = 12:size(alphabet,1)-1;
    n2 = n1 + beat_samp - 1;
    
    tone1       = key2note(X,tonic,beat_dur,fs);
    
    signal_A    = tonedRhythm(alphabet(1,:), tonic, beat_dur, fs);
    
    note        = tonic+mode(1+mod(i,length(mode)));
    signal_on   = tonedRhythm(alphabet(i,:), note, beat_dur, fs);
    
    signal_off  = [binMask(alphabet(16,:), length(tone1)) binMask(alphabet(16,:), length(tone1))];
    
    signal      = [signal_A signal_on signal_off];
    
    song(n1:n2) = signal;
    
    n1 = n2 + 1;
end