function signal = tonedRhythm(rhythm_pattern, note, duration, fs)

% Creates rhythm with a tone.

%%
signal = key2note(1,note,duration,fs);
signal = signal .* binMask(rhythm_pattern, length(signal));