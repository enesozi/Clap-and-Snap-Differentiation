prompt = 'What is the name of file(enter without .wav extension) ';
M = input(prompt,'s');
hfile = strcat(M,'.wav');
[f,fs] = audioread(hfile);      % Read wav file.
N = size(f,1);
df = fs / N;
w = (-(N/2):(N/2)-1)*df;
y = fft(f(:,1:1));              % Make fft of this file.
y2 = fftshift(y);               % Apply fftshift and plot 
plot(w,abs(y2)); xlabel('Hz'); ylabel('Db'); title(strcat(M,'.wav'));
absSignal=abs(y);   
meanOfSound=mean(absSignal);    % Average frequency power value
threshold = meanOfSound + 0.5;  % Set threshold for the power
sumFreq = 0;
countPeaks = 0;
N = N/2;
for j=1:N
   if absSignal(j)>threshold        % if power at that frequency is above threshold
      sumFreq=sumFreq+j*df;         % Sum that frequency.
      countPeaks=countPeaks+1;      % Ýncrements number of peaks considered as valid
   end
end
ratio = sumFreq/(countPeaks*(10^3));
if ratio >=4
fprintf('Snap sound detected\n');
else
fprintf('Clap sound detected\n');    
end