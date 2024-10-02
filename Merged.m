% Parameters
Fs = 44100;               % Sampling frequency
T = 1;                   % Duration of the signal
f = 1000;                % Frequency of the sine wave
t = 0:1/Fs:T-1/Fs;       % Time vector

% Clean 1000 Hz signal
clean_signal = sin(2*pi*f*t);

% Sine wave frequency resolution
desired_resolution_sine = 2;  % 2 Hz frequency resolution
nFFT_sine = ceil(Fs / desired_resolution_sine);  % Points to achieve 2 Hz (FFT)

% Zero-padding check
if nFFT_sine > length(clean_signal)
    clean_signal = [clean_signal, zeros(1, nFFT_sine - length(clean_signal))];  % Zero-pad the sine wave to length nFFT_sine
end

% FFT
X = fft(clean_signal, nFFT_sine);

% FFT magnitude
magX = abs(X);

% dB Conversion
magX_dB = 20*log10(magX + eps);  % Add eps to avoid log(0)

% Normalizing
magX_dB = magX_dB - max(magX_dB);

% Frequency vector
f_axis_sine = (0:nFFT_sine-1)*(Fs/nFFT_sine);


% Loading sound
[y, fs] = audioread('ericaparken 57.mp3');

% recording frequency resolution
desired_resolution_audio = 2;  % 2 Hz frequency resolution
nFFT_audio = ceil(fs / desired_resolution_audio);  % Number of points in FFT to achieve 2 Hz resolution

% Zero-padding check
if nFFT_audio > length(y)
    y = [y; zeros(nFFT_audio - length(y), 1)];  % Zero-pad the audio file to length nFFT_audio
end


% FFT
Y = fft(y, nFFT_audio);               % FFT zero-padded signal
magY = abs(Y);                  % FFt Magnitude

% Magnitude to dB
magY_dB = 20 * log10(magY + eps);

% Normalizing magnitude spectrum (0 dB peak)
magY_dB = magY_dB - max(magY_dB); 

% Frequency vector recording
f_axis_audio = (0:nFFT_audio-1)*(fs/nFFT_audio);  % Frequency vector

% Plot
figure;
hold on;

% Plot sine wave
plot(f_axis_sine(1:length(f_axis_sine)/2), magX_dB(1:length(magX_dB)/2), 'r', 'DisplayName', '1000 Hz Sine Wave');

% Plot recording
plot(f_axis_audio(1:floor(nFFT_audio/2)), magY_dB(1:floor(nFFT_audio/2)), 'b', 'DisplayName', 'Recording');

% Titles
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Normalized Magnitude Spectrum: 1000 Hz Sine Wave vs Recording');
legend;
xlim([0, 3000]);
grid on;
hold off;
