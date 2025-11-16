%------------------------------
% Assigment 3, Part 1
% Meng Edge Computing
% -----------------------------
% purpose: generate Z Transformed xn digital sinusoid 
%
% created by: Deniz Calik 
% ID: 25321919
%
% created on 10/11/2025
%------------------------------
clc;
clear all;
close all;



fs = 1.2e6; % given sampling frequency 
T = 1/fs;  % time step
f0 = 100e3; % given f0
A = 1; % 1V Amplitude
N = 256; % we are going to check for N = 256 (for fft 2^8)
t = (0:N-1)/fs;


% we are going to use our z tranform answer as tranfer fun H(z)
% H(z) = sin(wT)/( 1-2*cos(wT)*z^(-1) + z^(-2) )
% a coefficients = (1, -2*cos(wT), 1)
% b coefficient = sin(wT)

wT = 2 * pi * f0 * T; 




% denominator a and numerator b coefficient of our H(z)
% calculate impulse response xn of transfer function H_z the Z-transform
% generating our output signal yn with applying the Z-transform H(z) to the impulse response xn
% we generate a impulse response as xn (1 at 0 and 0 anywhere else)

% we use Computational Method 
% DSP filter function
xn = zeros(1,N);
xn(1) = 1; % set the first sample 1 for impulse function 
b = [A*sin(wT) 0]; % b0 is A*sin(w) and b1, b2 ... 0
a = [1 , -2*cos(wT) , 1]; % a0 is 1(almost always 1), a2 is -2*cos(w), a3 is 1
yn = filter(b, a, xn); 
% impulse response of our system is equal to its output
% so we should get f0 100kHz frequency at the output



% time-domain and frequency domain responses 
% Plot the time-domain response

figure(1);
plot(t(1:N), yn(1:N)); % plot for show in continues value
title('Time Domain Continuous Values');
xlabel('Time (s)');
ylabel('Amplitude (V)');
ylim([-2 2]);

figure(2);
stem(t(1:N), yn(1:N)); % stem for show in descrete values
title('Time Domain y(n) Discrete Values');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-2 2]);


% Plot the frequency-domain response using FFT
figure(3);
f = (0:N-1)*(fs/N); % frequency vector
y_freq = fft(yn); % compute the FFT of the output
plot(f, abs(y_freq));
title('Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 fs/2]); % Nyquist frequency fs/2
