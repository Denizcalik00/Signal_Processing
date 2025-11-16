%------------------------------
% Assigment 2, Part 1
% Meng Edge Computing
% -----------------------------
% purpose: DFT and single sided power spectrum
%
% created by: Deniz Calik 
% ID: 25321919
%
% created on 17/10/2025
%------------------------------
clc;
clear all;
close all;

% column vector because , window func also column vec
x = [-6; 5; 4; 3];
N = length(x); 

Whm=hamming(N);% window function
Xhm = x.*Whm; % applying the window function
y = fft(Xhm); % DFT result
fs = 100;

% single-sided power spectrum

% pow. spectrum formula for Pk values
Py = y.*conj(y);
Py = Py/(N^2); 

Py(2:N/2 + 1) = 2*Py(2:N/2 + 1); % doubled Pk values except P0 
Py = Py(1:N/2 +1 ); %the first half of the power spectrum (exclude mirror)
Py1 = Py / max(Py); % Normalize to the highest coefficient value
Py_db = 10*log10(Py1); % single-sided power spectrum in dB
 
%plot the power spectrum in frequency domain
f = (0:N/2) * (fs / N); % frequency bins
figure(1); % create a new figure
plot(f, Py_db); % plot the single-sided power spectrum
xlabel(' frequency hz ');
ylabel(' power spectrum db ');
title(' single Sided power spectrum ');

