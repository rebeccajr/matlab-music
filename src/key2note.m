function xx = key2note(X, keynum, dur, fs)
% KEY2NOTE Produce a sinusoidal waveform corresponding to a 
% given piano key number
%
% usage: xx = key2note (X, keynum, dur)
%
% xx     = the output sinusoidal waveform
% X      = complex amplitude for the sinusoid, X = A*exp(j*phi).
% keynum = the piano keyboard number of the desired note
% dur    = the duration (in seconds) of the output note

tt   = 0:(1/fs):dur;
freq = 440*2^((keynum-69)/12);
xx   = real( X*exp(1i*2*pi*freq*tt) );



