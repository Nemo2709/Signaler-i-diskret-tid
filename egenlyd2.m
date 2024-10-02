% Generationg a clean 1000 Hz sine wave
Fs = 44100;  % Sampling frequency 
T = 0.01;    % Duration in seconds
f = 1000;    % Frequency sine wave
t = 0:1/Fs:T-1/Fs;  % Time vector

% Clean 1000 Hz signal
clean_signal = sin(2 * pi * f * t);

% Loading the recorded sound
[y, fs] = audioread('Ericaparken 57.mp3');

% Mathing recorded signal to clean signal duration
nSamples = min(length(y), length(clean_signal));  % Ensure equal sampling size
recorded_signal = y(1:nSamples);  % Truncating recorded signal to clean signal duration

% Normalizing recorded signal
recorded_signal = recorded_signal / max(abs(recorded_signal));  % Normalize between -1 and 1

% Time vector for recorded signal
t_recorded = (0:nSamples-1) / fs;  % Time vector for the recorded signal

% Plotting signals
figure;
plot(t(1:nSamples), clean_signal(1:nSamples), 'b');  % Plot clean signal in blue
hold on;
plot(t_recorded(1:nSamples), recorded_signal, 'r');  % Plot recorded signal in red
hold off;

% plot titles
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Clean 1000 Hz Signal vs Recorded Sound');
legend('Clean 1000 Hz signal', 'Recording');
grid on;
