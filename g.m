function y = g(n)
% Compute the function
y = 10*(0.8)^n*sin(3*pi*n/16)*usD(n);
I = round(n) ~= n; % Find all non-integer �n�s�
y(I) = NaN; % Set those return values to �NaN�
end
% Graphing a discrete-time function and compressed and expanded
% transformations of it
% Compute values of the original function and the time-scaled
% versions in this section

n = -5:48 ; % Set the discrete times for
% function computation
g0 = g(n) ; % Compute the original function
% values
g1 = g(2*n) ; % Compute the compressed function
% values
g2 = g(n/3) ; % Compute the expanded function
% values
% Display the original and time-scaled functions graphically
% in this section
%
% Graph the original function
%
subplot(3,1,1) ; % Graph fi rst of three graphs
% stacked vertically
p = stem(n,g0,'k','filled'); % �Stem plot� the original function
set(p,'LineWidth','2','MarkerSize',4); % Set the line weight and dot
% size
ylabel('g[n]'); % Label the original function axis
%
% Graph the time-compressed function
%
subplot(3,1,2); % Graph second of three plots
% stacked vertically
p = stem(n,g1,'k','filled'); % �Stem plot� the compressed
% function
set(p,'LineWidth','2','MarkerSize',4); % Set the line weight and dot
% size
ylabel('g[2n]'); % Label the compressed function
% axis
%
% Graph the time-expanded function
%
subplot(3,1,3); % Graph third of three graphs
% stacked vertically
p = stem(n,g2,'k','filled') ; % �Stem plot� the expanded
% function
set(p,'LineWidth','2','MarkerSize',4); % Set the line weight and dot
% size
xlabel('Discrete time, n'); % Label the expanded function axis
ylabel('g[n/3]'); % Label the discrete-time axis