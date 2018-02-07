%% Use constant N and K, change alpha from 0 to 1 and plot SNR of mike.wav and recovered signal.
[mike,fs] = audioread('mike.wav');
K=fs*100/1000;	% Convert 100 ms to s and multiply with fs
N=20; % Set N to 20
snrVector=linspace(0,0,200);
index=0;
for alpha=0:0.005:1
    convCeff=linspace(0,0,N*K+1);
    for j=0:N
       convCeff(j*K+1)=(-alpha)^j;    % Create and fill coefficient vector.
    end
    index=index+ 1;
    filteredMike=conv(convCeff,mike);   % Make convolution
    signal = mike;                  % Calculate SNR value for the spesific alpha value.
                                         % Last lines of code is to calculate SNR           
    noise_reduced_signal = filteredMike(1:length(mike));
    residual_noise = signal - noise_reduced_signal; 
    snr_after = mean( signal .^ 2 ) / mean( residual_noise .^ 2 ); 
    snr_after_db = 10 * log10( snr_after );
    snrVector(index)=snr_after_db;
    
end
alphaVEc=0:0.005:1;
figure
plot(alphaVEc,snrVector),title('SNR of mike.wav and recovered signal for alpha between 0 to 1');xlabel('alpha'); ylabel('SNR');

clear;
%% Use constant alpha and K, change N from 1 to 50 and plot SNR of mike.wav and recovered signal.
[mike,fs] = audioread('mike.wav');
K=fs*100/1000;  % Convert 100 ms to s and multiply with fs
alpha = 0.5;    % Set alpha to 0.5
snrVector=linspace(0,0,50);
index=0;
for n=1:50
    convCeff=linspace(0,0,n*K+1);  
    for j=0:n
       convCeff(j*K+1)=(-alpha)^j; % Create and fill coefficient vector.
    end
    index=index+ 1;
  filteredMike=conv(convCeff,mike);   % Make convolution
    signal = mike;                  % Calculate SNR value for the spesific N value.
                                         % Last lines of code is to calculate SNR           
    noise_reduced_signal = filteredMike(1:length(mike));
    residual_noise = signal - noise_reduced_signal; 
    snr_after = mean( signal .^ 2 ) / mean( residual_noise .^ 2 ); 
    snr_after_db = 10 * log10( snr_after );
    snrVector(index)=snr_after_db;
end
nVec=1:50;
figure
plot(nVec,snrVector),title('SNR of mike.wav and recovered signal for N between 1 to 50'); xlabel('N'); ylabel('SNR');
%% Use constant alpha and N, change K from 100 to 400 ms and plot SNR of mike.wav and recovered signal.
[mike,fs] = audioread('mike.wav');
K=fs*100/1000; % Convert 100 ms to s and multiply with fs
alpha = 0.5;
N=20;
snrVector=linspace(0,0,4);
index=0;
for k=1:4
    K=round(fs*k/10);%100 miliseconds
    convCeff=linspace(0,0,N*K+1);
    for j=0:N
       convCeff(j*K+1)=(-alpha)^j; 
    end
    index=index+ 1;
   filteredMike=conv(convCeff,mike);   % Make convolution
    signal = mike;                  % Calculate SNR value for the spesific K value.
                                         % Last lines of code is to calculate SNR           
    noise_reduced_signal = filteredMike(1:length(mike));
    residual_noise = signal - noise_reduced_signal; 
    snr_after = mean( signal .^ 2 ) / mean( residual_noise .^ 2 ); 
    snr_after_db = 10 * log10( snr_after );
    snrVector(index)=snr_after_db;
    
end
kvector=1:4;
figure
plot(kvector*100,snrVector),title('SNR of mike.wav and recovered signal for K from 100 to 400 ms'); xlabel('K'); ylabel('SNR');
