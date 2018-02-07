%% 1- Frequency Domain Representaion of Street.wav , Mike.wav and
%Street+Mike.wav

% Street.wav
[f,fs] = audioread('street.wav');
N = size(f,1);
df = fs / N;                
w = (-(N/2):(N/2)-1)*df;  
y = fft(f(:,1), N);    %Convert to frequence domain
y2 = fftshift(y);      %Make fft shift     
figure
subplot(3,1,1)
plot(w,abs(y2)); 
xlabel('Frequency (Hz)')
ylabel('Power')
title('Street.wav');

% Mike.wav
[f2,fs] = audioread('mike.wav');
N = size(f2,1);
df = fs / N;
w = (-(N/2):(N/2)-1)*df;
y = fft(f2(:,1), N);
y(1) = 0;
y3 = fftshift(y);
y3(y3<10) = 0;
subplot(3,1,2)
plot(w,abs(y3));
xlabel('Frequency (Hz)')
ylabel('Power')
title('Mike.wav');

%Mike+Street.wav
f3 = f2+f;    % Add two signals to obtain mixed function
N = size(f3,1);
df = fs / N;
w = (-(N/2):(N/2)-1)*df;
y = fft(f3(:,1), N);
y(1) = 0;
y2 = fftshift(y);
subplot(3,1,3)
plot(w,abs(y2));
xlabel('Frequency (Hz)')
ylabel('Power')
title('Street+Mike.wav');

%% 2- Time Domain Representaion of Street.wav , Mike.wav and
%Street+Mike.wav

%Street.wav
[y,fs] = audioread('street.wav');
t = linspace(0,length(y)/fs,length(y));
figure(2)
subplot(3,1,1);
plot(t,y); title('street.wav');	xlabel('Seconds'); ylabel('Amplitude');

%Mike.wav
[y2,fs] = audioread('mike.wav');
t = linspace(0,length(y2)/fs,length(y2));
figure(2)
subplot(3,1,2);
plot(t,y2); title('mike.wav'); xlabel('Seconds'); ylabel('Amplitude');

%Mike+Street.wav
y3 = y+y2;  % Add 2 signals in time domain
t = linspace(0,length(y3)/fs,length(y3));
figure(2)
subplot(3,1,3);
plot(t,y3); title('mike+street.wav'); xlabel('Seconds'); ylabel('Amplitude');


%% 3 Frequency Domain Representaion of Mike.wav and Filtered Mike+Street.wav 
% Street.wav
[f,~] = audioread('street.wav');

% Mike.wav
[f2,fs] = audioread('mike.wav');
N = size(f2,1);
df = fs / N;
w = (-(N/2):(N/2)-1)*df;
y = fft(f2(:,1), N);
y(1) = 0;
y2 = fftshift(y);
figure(3)
subplot(2,1,1)
plot(w,abs(y2)); title('mike.wav'); xlabel('Hz'); ylabel('Db'); 

%Mike+Street.wav
f3 = f2+f;
N = size(f3,1);
df = fs / N;
w = (-(N/2):(N/2)-1)*df;
y = fft(f3(:,1), N);
y(1) = 0;                       
y(1:50/df) = 0;                 % Filtering out sound from a spesific band
y((fs-50)/df:end) = 0;          % Make values 0 outside of this range.
y(3000/df:(fs-3000)/df) = 0;    % Range is 50-3000 Hz
y2 = fftshift(y);
subplot(2,1,2)
plot(w,abs(y2));
xlabel('Hz')
ylabel('Db')
title('Filtered Street+Mike.wav');

%% 4 Time Domain Representaion of Mike.wav and Filtered Mike+Street.wav

%Mike.wav
[y2,fs] = audioread('mike.wav');
t = linspace(0,length(y2)/fs,length(y2));
figure(4)
subplot(2,1,1);
plot(t,y2); title('Mike.wav'); xlabel('Seconds'); ylabel('Amplitude');

% Filtered Mike+Street.wav
Y = real((ifft(y)));     % To convert back to tiime domain
t = linspace(0,length(Y)/fs,length(Y));
subplot(2,1,2);
plot(t,Y); title('Filtered Mike+Street.wav'); xlabel('Seconds'); ylabel('Amplitude');

%% play filtered sound
% sound(Y,fs);

%% SNR Value Calculation
signal = y2;
noise_reduced_signal = Y;
residual_noise = signal - noise_reduced_signal; 
snr_after = mean( signal .^ 2 ) / mean( residual_noise .^ 2 ); 
snr_after_db = 10 * log10( snr_after );
fprintf('SNR value is %f \n',snr_after_db);