%------------------------------
% Assigment 3, Part 2-1
% Meng Edge Computing
% -----------------------------
% purpose: FIR filter 
%
% created by: Deniz Calik 
% ID: 25321919
%
% created on 10/11/2025
%------------------------------
clc;
clear all;
close all;



fs = 8e3; % Sampling frequency
f_pass = 1.6e3; % Passband frequency
f_stop = 1.8e3; % Stopband frequency

% we will be using hamming function because our ripple and attenuation
% fits for hamming from table


fdelta = abs(f_stop - f_pass)/fs;
N = 3.3/fdelta;

% to check N add or not I go this way
% Round to nearest integer
N = round(N);

% If N is even, make it the next odd number
if mod(N,2) == 0
    N = N + 1;
end

n = N-1; % order of the filter Length - 1



% filter cut off frequency
fc = (f_pass + f_stop) / 2; % Cutoff frequency
% normalized cut off in rad
wn = fc/(fs/2); 


% generate the windowed FIR coefficients
% fir1 command applies correction for unity gain
bhan = fir1(n, wn,'low', hamming(N));


% pole-zero Map
figure(1)
zplane(bhan,1)
% frequency Response using rad
figure(2)
freqz(bhan,1, 512, fs);




% frequency responce using hz freqz(b,a)
figure(3);
[H, f] = freqz(bhan, 1, 512, fs);
plot(f, 20*log10(abs(H)));
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude Response of the FIR Filter');





%plot the speech samples 
load noisy_speech.dat



x = noisy_speech;
N_speech = length(x);
t = (0:N_speech-1)/fs;  

x_filtered = filter(bhan, 1, x);


% Plot the noisy speech samples
figure(4);
plot(t,x);
xlabel('Time s');
ylabel('Amplitude');
title('Noisy Speech Signal Time Domain');

%plot enhanced speech
figure(5);
plot(t,x_filtered);
xlabel('Time s');
ylabel('Amplitude');
title('Enhanced Speech Signal Time Domain');


% to plot spectrum we calculate fft for noisy and enhanced 

Nfft = 16384;  % very high resolution FFT
X = fft(x, Nfft);
Y = fft(x_filtered, Nfft);
f = (0:Nfft-1)*(fs/Nfft); % frequency axis



% Plot the magnitude spectrum of the noisy speech signal


figure(8);
plot(f(1:Nfft/2), abs(X(1:Nfft/2))); 
% because fft has mirror positif and negatif fs/2 so it makes 0 to fs
% and we want to plot only nyquist part 0 to fs/2
title('Spectrum of Noisy Speech');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

figure(9);
plot(f(1:Nfft/2), abs(Y(1:Nfft/2)));
title('Spectrum of Enhanced Speech');
xlabel('Frequency (Hz)');
ylabel('Amplitude');






