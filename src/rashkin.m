% Rashkin
% DSP Final Project
% Spring 2016

%% housekeeping
clear all
close all
clc

%% set parameters
fs       = 11025;
bpm      = 80;
time_sig = 4;
X        = 1;

%% assign midi notes

% columns = note, rows = octave, only root notes
% c d e f g
notes = zeros(8,7);

notes(1,:) = [24 26 28 29 31 33 35];

for i=2:length(notes)
    notes(i,:) = 12 + notes(i-1,:);
end

%% print midi notes in table

fprintf('oct|  c   d   e   f   g   a   b\n');
fprintf('---------------------------------\n');
for i=1:length(notes)
    fprintf('%2d |',i);
    for j=1:length(notes(i,:))
        fprintf('%3d ',notes(i,j));
    end
    fprintf('\n');
end

note_c = notes(:,1);
note_d = notes(:,2);
note_e = notes(:,3);
note_f = notes(:,4);
note_g = notes(:,5);
note_a = notes(:,6);
note_b = notes(:,7);

%% assign note times in seconds per beat
quarter   = 60 / bpm; % 60 seconds /min * (min/beats)
half      = quarter * 2;
whole     = quarter * 4;
eighth    = quarter / 2;
sixteenth = quarter / 4;

%% # samples per note type

samp_q = floor(fs * quarter);
samp_h = floor(fs * half);
samp_w = floor(fs * whole);
samp_e = floor(fs * eighth);
samp_s = floor(fs * sixteenth);

%% assign alphabet
alphabet = rhythmAlphabet();

% r for rhythm
r_A = alphabet(1,:);
r_B = alphabet(2,:);
r_C = alphabet(3,:);
r_D = alphabet(4,:);
r_E = alphabet(5,:);
r_F = alphabet(6,:);
r_G = alphabet(7,:);
r_H = alphabet(8,:);
r_I = alphabet(9,:);
r_J = alphabet(10,:);
r_K = alphabet(11,:);
r_L = alphabet(12,:);
r_M = alphabet(13,:);
r_N = alphabet(14,:);
r_O = alphabet(15,:);
r_P = alphabet(16,:);

%% create 4 practice songs in different modes of keys

beat_dur = quarter;

tonic = note_g(5);

major      = [1 5 8 12];
minor      = [1 4 8 11];
dominant   = [1 5 8 11];
diminished = [1 4 7 11];

song1 = practice1(tonic, major, beat_dur, fs);
song2 = practice1(tonic, minor, beat_dur, fs);
song3 = practice1(tonic, dominant, beat_dur, fs);
song4 = practice1(tonic, diminished, beat_dur, fs);

%% metronome

metro_note  = note_c(5);
metro_beat  = quarter;
metro_dur   = floor(length(song1)/(fs));

metro = framingRhythm(r_H, metro_note, bpm, length(song1), fs, X);

%function metro = metronome(rhythm, midi_note, bpm, melody, fs, X)

%% combine rhythms

m_song1 = 1/2 * metro + 1/2 * song1;
m_song2 = 1/2 * metro + 1/2 * song2;
m_song3 = 1/2 * metro + 1/2 * song3;
m_song4 = 1/2 * metro + 1/2 * song4;

audiowrite('song_major.wav',m_song1,fs);
audiowrite('song_minor.wav',m_song2,fs);
audiowrite('song_dominant.wav',m_song3,fs);
audiowrite('song_diminished.wav',m_song4,fs);

soundsc(m_song1,fs);

%% images 

limit1 = [0 5500 -0.5 1.5];
limit2 = [0 5500 -1.5 1.5];
limit3 = [0 8 0 1500];
color2 = [.57 .23 .4];
color1 = [.22 .43 .48];

tone = key2note(1, tonic, quarter, fs);

figure()
subplot(3,1,1)
mask = binMask(r_E, length(tone));
plot(mask, 'color', color1)
title('Binary Mask - 1 1 0 1')
axis('xy', limit1)
ylabel('Amplitude')

subplot(3,1,2)
hold on
axis('xy', limit2)
plot(tone, 'color', color1)
title('Tone Signal - C5: 523 Hz')
ylabel('Amplitude')

subplot(3,1,3)
rhythm = key2note(1, tonic, quarter, fs);
hold on
axis('xy', limit2)
plot(tone .* mask, 'color', color1)
title('Enveloped Signal')
ylabel('Amplitude'), xlabel('Sample')

%%
window = 120;
noverlap = 0;

window1 = length(song1) / 100;
window2 = length(song1) / 400;
window3 = length(song1) / 1600;
window4 = length(song1) / 200;

figure()
subplot(4,1,1)
[aa, bb, cc] = spectrogram(song1,[],[],[],fs,'yaxis');
imagesc(cc,bb,db(aa,40));
title('Default, 8 Segments')
axis('xy', limit3)
ylabel('Frequency (Hz)')

subplot(4,1,2)
[aa, bb, cc] = spectrogram(song1,window1,[],[],fs,'yaxis');
imagesc(cc,bb,db(aa,40));
title('100 Segments')
axis('xy', limit3)
ylabel('Frequency (Hz)')

subplot(4,1,3)
[aa, bb, cc] = spectrogram(song1,window2,[],[],fs,'yaxis');
imagesc(cc,bb,db(aa,40));
title('400 Segments')
axis('xy', limit3)
ylabel('Frequency (Hz)')

subplot(4,1,4)
[aa, bb, cc] = spectrogram(song1,window3,[],[],fs,'yaxis');
imagesc(cc,bb,db(aa,40));
title('1600 Segments')
axis('xy', limit3)
ylabel('Frequency (Hz)'), xlabel('Time (sec)')

%%
fig3rows = 4;
fig3cols = 1;

overlap1 = floor(window4*.75);
overlap2 = floor(window4*.9999);

figure ()
subplot(fig3rows,fig3cols,1)
[aa, bb, cc] = spectrogram(song1,window4,0,[],fs,'yaxis');
imagesc(cc,bb,db(aa,40));
title('0% Overlap')
axis('xy', limit3)
ylabel('Frequency (Hz)')

subplot(fig3rows,fig3cols,2)
[aa, bb, cc] = spectrogram(song1,window4,[],[],fs,'yaxis');
imagesc(cc,bb,db(aa,40));
title('50% Overlap (Default)')
axis('xy', limit3)
ylabel('Frequency (Hz)')

subplot(fig3rows,fig3cols,3)
[aa, bb, cc] = spectrogram(song1,window4,overlap1,[],fs,'yaxis');
imagesc(cc,bb,db(aa,40));
title('75% Overlap')
axis('xy', limit3)
ylabel('Frequency (Hz)')

subplot(fig3rows,fig3cols,4)
[aa, bb, cc] = spectrogram(song1,window4,overlap2,[],fs,'yaxis');
imagesc(cc,bb,db(aa,40));
title('99.99% Overlap')
axis('xy', limit3)
ylabel('Frequency (Hz)'), xlabel('Time (sec)')

%%
fig4rows = 3;
fig4cols = 1;

figure ()
subplot(fig4rows,fig4cols,1)
[aa, bb, cc] = spectrogram(metro,window4,[],[],fs,'yaxis');
imagesc(cc,bb,db(aa,40));
title('Framing Rhythm')
axis('xy', limit3)
ylabel('Frequency (Hz)')

subplot(fig4rows,fig4cols,2)
[aa, bb, cc] = spectrogram(song1,window4,[],[],fs,'yaxis');
imagesc(cc,bb,db(aa,40));
title('Syncopated Rhythm (Mode: Major)')
axis('xy', limit3)
ylabel('Frequency (Hz)')

subplot(fig4rows,fig4cols,3)
[aa, bb, cc] = spectrogram(m_song1,window4,[],[],fs,'yaxis');
imagesc(cc,bb,db(aa,40));
title('Combined Rhythm')
axis('xy', limit3)
ylabel('Frequency (Hz)'), xlabel('Time (sec)')


%%
fig5rows = 4;
fig5cols = 1;

figure ()
subplot(fig5rows,fig5cols,1)
[aa, bb, cc] = spectrogram(m_song1,window4,[],[],fs,'yaxis');
imagesc(cc,bb,db(aa,40));
title('Mode: Major')
axis('xy', limit3)
ylabel('Frequency (Hz)')

subplot(fig5rows,fig5cols,2)
[aa, bb, cc] = spectrogram(m_song2,window4,[],[],fs,'yaxis');
imagesc(cc,bb,db(aa,40));
title('Mode: Minor')
axis('xy', limit3)
ylabel('Frequency (Hz)')

subplot(fig5rows,fig5cols,3)
[aa, bb, cc] = spectrogram(m_song3,window4,[],[],fs,'yaxis');
imagesc(cc,bb,db(aa,40));
title('Mode: Dominant')
axis('xy', limit3)
ylabel('Frequency (Hz)')

subplot(fig5rows,fig5cols,4)
[aa, bb, cc] = spectrogram(m_song4,window4,[],[],fs,'yaxis');
imagesc(cc,bb,db(aa,40));
title('Mode: Diminished')
axis('xy', limit3)
ylabel('Frequency (Hz)'), xlabel('Time (sec)')
