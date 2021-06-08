function signal = binMask(input_pattern, samples)

% Creates binary sound mask to create rhythms from tone
%
% Usage: signal = binMask(input_pattern, samples)
%
% input_pattern = binary 1D array (generally 4 notes) e.g. [1 0 0 0]
% samples       = total number of samples
%
% After creating this binary mask, multiply it with a tone signal of the
% same length to create a rhythm.
%
% e.g. signal      = binMask(input_pattern, samples)
%      masked_tone = signal * key2note(X, keynum, dur, fs)

signal  = zeros(1,samples);

% length of sound is 1/2 the length of the beat
len_sound = ceil(samples / (2*length(input_pattern)));
len_samp  = ceil(samples / length(input_pattern));

n1 = 1;
for i = 1:length(input_pattern)
    x1 = input_pattern(i) * ones(1,len_sound);
    n2 = n1 + len_sound - 1;
    
    signal(n1:n2) = x1;
    
    n3 = n1 + len_samp - 1;
    n1 = n3 + 1;
end