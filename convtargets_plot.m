% Plot the convolution targets
%
% Samuli Siltanen September 2019

% Parameters for plotting
lwidth = 1.5;

% Construct evaluation points
t = linspace(0,1,512);

% Create plot window
figure(1)
clf

% Plot the targets
subplot(2,1,1)
plot(t,convtarget1(t),'b','linewidth',lwidth)
ylim([-1.2 1.6])
subplot(2,1,2)
plot(t,convtarget2(t),'b','linewidth',lwidth)
ylim([-1.2 1.6])
