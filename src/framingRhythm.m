function frame = framingRhythm(rhythm, midi_note, bpm, metro_samp, fs, X)

% Creates metronome signal
% 
% Usage: signal = metronome(midi_note, bpm, duration, fs, X)
% 
% rhythm     = binary mask
% midi_note  = midi note tone of framing rhythm
% bpm        = beats per minute
% metro_samp = total number of samples
% fs         = sampling frequency
% X          = complex signal amplitude

metro_beat  = 60/bpm;
beat_samp   = length(0:(1/fs):metro_beat);

metro_tone  = key2note(X,midi_note,metro_beat,fs);

frame       = zeros(1,metro_samp);

signal      = binMask(rhythm, length(metro_tone));% .* metro_tone;

n1 = 1;
for i = 1:beat_samp:metro_samp
    n2 = n1 + beat_samp - 1;
    frame(n1:n2) = signal;
    n1 = n2 + 1;
end






% quarter = 60 / bpm;
% beat_dur = quarter;
% 
% beat_samp = ceil(fs*quarter);
% 
% metro_beats  = duration / quarter;
% 
% metro = zeros(1,beat_samp*metro_beats);
% 
% n1 = 1;
% for i = 1:metro_beats
%     n2 = n1 + beat_samp - 1;
%     
%     signal           = binMask([1 0 0 0],beat_dur,fs);
%     signal           = signal .* key2note(X,midi_note,beat_dur,fs);
%     metro(n1:n2) = signal;
%     
%     n1 = n2 + 1;
% end
