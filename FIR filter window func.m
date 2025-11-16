%------------------------------
% Assigment 3, Part 2-2
% Meng Edge Computing
% -----------------------------
% purpose: FIR filter Fourier Transform
%
% created by: Deniz Calik 
% ID: 25321919
%
% created on 10/11/2025
%------------------------------
clc;
clear all;
close all;


fs = 10e3;
fcl = 1.5e3;
fch = 3e3;

N = 31; % length = 31 ,  31-tap bandpass FIR filter
M=(N-1)/2; % -M <n < M , to shift it find middle value (31-1)/2 = 15
n = 30; % order of the filter (lenght - 1) = 30

% normalized cut offs
wnl = fcl/(fs/2);
wnh = fch/(fs/2);


% so Design a 31-tap bandpass FIR filter using the Fourier Transform method





% from table we used bandpass equation
% for n = 0  , hn = hn(n) = (wnh - wnl)
% for != 0 , hn(n) = (sin(wnh*n*pi) / (n*pi)) - (sin(wnl*n*pi) / (n*pi)) 


for k = 1:31 % 31-tap filter
    i = k-(M+1);
    if k==M+1
        % for n=0;
        hn(k) = (wnh - wnl); 
    
    else
        % for n != 0;
        hn(k) = (sin(wnh*(i)*pi) / (i*pi)) - (sin(wnl*(i)*pi) / (i*pi)); % Ideal bandpass filter
        % ideally we could have also used elseif to match mirrored value 
        % to run the code faster
    end
end

hn = hn'; % to switch hn form row vector to column vector to not create a matrix
bhan2= hn.*hann(N);
bblack2= hn.*blackman(N);

% frequency Response hanning window from table equation
figure(1);
title('Hann Window Function of Filter ');
freqz(bhan2,1, 512, fs);
% display numerical value of coeffiecients of bhan2
disp('Numerical values of coefficients of bhan2:');
disp(bhan2');



% frequency Response blackman window from table equation 
figure(2);
title('Blackman Window Function of Filter ');
freqz(bblack2, 1, 512, fs);

% display numerical value of coefficients of bblack2
disp('Numerical values of coefficients of bblack:');
disp(bblack2');


%==================================================================
% hanning window function of filter using fir1
bhan = fir1(n, [wnl wnh],'bandpass', hann(N));

% display numerical value of coeffiecients of bhan
disp('Numerical values of coefficients of bhan:');
disp(bhan);


% frequency Response using rad for hann
figure(3);
title('Hann Window Function of Filter ');
freqz(bhan,1, 512, fs);


% blackman window function of filter 
bblack = fir1(n, [wnl wnh], 'bandpass', blackman(N));

% display numerical value of coefficients of bblack
disp('Numerical values of coefficients of bblack:');
disp(bblack);

% frequency Response using rad for blackman window
figure(4);
title('Blackman Window Function of Filter ');
freqz(bblack, 1, 512, fs);



