%------------------------------
% Assigment 3, Part 2-3
% Meng Edge Computing
% -----------------------------
% purpose: FIR filter  Frequency Sampling Method
%
% created by: Deniz Calik 
% ID: 25321919
%
% created on 10/11/2025
%------------------------------
clc;
clear all;
close all;


fs = 32e3; % smapling f
fc = 8e3; % cut off
N = 19; % lenght is 19 
M = (N-1)/2; % middle index

% normalized cut offs
wn = fc/(fs/2);


%H[k] = 0 when frequency < fc
%H[k] = 1 when frequency ≥ fc
for k = 0:1:M % counts half of length

    % we check the formula omegaK > wn(cut off rad); then 1 , if not 0

    omegaK(k+1) = (2.0*k/N);   % frequency of bin k
    if omegaK(k+1) >= wn
        Hdk(k+1) = 1;
    else
        Hdk(k+1) = 0;
    end
end

% because highpass last index should be 1 and the firs is 0
omegaK(end)=1; 

for n = 0:1:M
    sum_cos = 0;
    for k = 1:1:M
        sum_cos = sum_cos + Hdk(k+1)*cos(2*pi*k*(n-M)/N);
    end
    hn(n+1) = (1/N) * ( Hdk(1) + 2*sum_cos );
end

% we match mirror to get symmetric FIR

for n = M+2:1:2*M+1
    hn(n) = hn(2*M+2 - n); 
    % hn(11) = hn(9), hn(12) = hn(8) ..... hn(19) = hn(1)
    % so we get h(1) .... h(10).... h(19) mirrored 
end


h_win = hn .*hamming(N)';
figure(1);
freqz(h_win,1,512)



%===================================================================
% using fir2 command for frequency smapling method 


bhi = fir2(N,omegaK,Hdk);
figure(2);
freqz(bhi,1,512)

figure(3);
plot(omegaK,Hdk);
xlabel('OmegaK');
ylabel('H(k)');

% =====================================================
% =====================================================

%=================== examples ===============

% ================ low pass ===================
clc;
clear all;
close all;


fs = 8e3; % smapling f
fc = 2e3; % cut off
N = 35; % lenght is 35 
M = (N-1)/2; % middle index
n = N-1;

% normalized cut offs
wn = fc/(fs/2);






%H[k] = 0 when frequency < fc
%H[k] = 1 when frequency ≥ fc
for k = 0:1:M % counts half of length

    % we check the formula omegaK > wn(cut off rad); then 1 , if not 0

    omegaK(k+1) = (2.0*k/N);   % frequency of bin k
    if omegaK(k+1) <= wn
        Hdk(k+1) = 1;
    else
        Hdk(k+1) = 0;
    end
end

% because highpass last index should be 1 and the firs is 0
omegaK(end)=1; 

for n = 0:1:M
    sum_cos = 0;
    for k = 1:1:M
        sum_cos = sum_cos + Hdk(k+1)*cos(2*pi*k*(n-M)/N);
    end
    hn(n+1) = (1/N) * ( Hdk(1) + 2*sum_cos );
end

% we match mirror to get symmetric FIR

for n = M+2:1:2*M+1
    hn(n) = hn(2*M+2 - n); 
    % hn(11) = hn(9), hn(12) = hn(8) ..... hn(19) = hn(1)
    % so we get h(1) .... h(10).... h(19) mirrored 
end


h_win = hn .*hamming(N)';
figure(1);
freqz(h_win,1,1024,fs)

figure(3);
plot(omegaK,Hdk);
xlabel('OmegaK');
ylabel('H(k)');


%=====================================================
%=====================================================

%================ high pass ===================
clc;
clear all;
close all;


fs = 8e3; % smapling f
fc = 2e3; % cut off
N = 35; % lenght is 35
M = (N-1)/2; % middle index
n = N-1;

% normalized cut offs
wn = fc/(fs/2);






%H[k] = 0 when frequency < fc
%H[k] = 1 when frequency ≥ fc
for k = 0:1:M % counts half of length

    % we check the formula omegaK > wn(cut off rad); then 1 , if not 0

    omegaK(k+1) = (2.0*k/N);   % frequency of bin k
    if omegaK(k+1) >= wn
        Hdk(k+1) = 1;
    else
        Hdk(k+1) = 0;
    end
end

% because highpass last index should be 1 and the firs is 0
omegaK(end)=1; 

for n = 0:1:M
    sum_cos = 0;
    for k = 1:1:M
        sum_cos = sum_cos + Hdk(k+1)*cos(2*pi*k*(n-M)/N);
    end
    hn(n+1) = (1/N) * ( Hdk(1) + 2*sum_cos );
end

% we match mirror to get symmetric FIR

for n = M+2:1:2*M+1
    hn(n) = hn(2*M+2 - n); 
    % hn(11) = hn(9), hn(12) = hn(8) ..... hn(19) = hn(1)
    % so we get h(1) .... h(10).... h(19) mirrored 
end


h_win = hn .*hamming(N)';
figure(1);
freqz(h_win,1,1024,fs)

figure(3);
plot(omegaK,Hdk);
xlabel('OmegaK');
ylabel('H(k)');