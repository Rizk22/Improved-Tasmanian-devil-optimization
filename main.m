%% Improved Tasmanian Devil Optimization Algorithm
% Reference:
% Rizk-Allah, Rizk M., Ragab A. El-Sehiemy, and Mohamed I. Abdelwanis.
% "Improved Tasmanian devil optimization algorithm for parameter
% identification of electric transformers."
% Neural Computing and Applications 36, no. 6 (2024): 3141-3166.

%%
clc
clear
close all

%% Problem Definition

Fun_name = 'F2';                    % Test functions: 'F1' to 'F23'

SearchAgents = 50;                  % Number of population members
Max_iterations = 1000;              % Maximum number of iterations

% Get test function information
[lowerbound, upperbound, dimension, fitness] = fun_info(Fun_name);

%% Run TDO

[Best_score, Best_pos, TDO_curve] = TDO( ...
    SearchAgents, ...
    Max_iterations, ...
    lowerbound, ...
    upperbound, ...
    dimension, ...
    fitness);

%% Run Improved TDO (IITDO)

[Best_score1, Best_pos1, TDO_curve1] = IITDO( ...
    SearchAgents, ...
    Max_iterations, ...
    lowerbound, ...
    upperbound, ...
    dimension, ...
    fitness);

%% Display Results

disp(['The best solution obtained by TDO for ', ...
    num2str(Fun_name), ' is: ', num2str(Best_pos)]);

disp(['The best optimal value of the objective function found by TDO for ', ...
    num2str(Fun_name), ' is: ', num2str(Best_score)]);

disp(['The best solution obtained by IITDO for ', ...
    num2str(Fun_name), ' is: ', num2str(Best_pos1)]);

disp(['The best optimal value of the objective function found by IITDO for ', ...
    num2str(Fun_name), ' is: ', num2str(Best_score1)]);

%% Convergence Curve

figure;

semilogy(1:Max_iterations, TDO_curve, 'LineWidth', 2);
hold on;

semilogy(1:Max_iterations, TDO_curve1, 'LineWidth', 2);

grid on;
box on;

xlabel('Iteration', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Best Fitness Value', 'FontSize', 12, 'FontWeight', 'bold');

title(['Convergence Curve for ', Fun_name], ...
    'FontSize', 13, 'FontWeight', 'bold');

legend('TDO', 'IITDO', ...
    'Location', 'best', ...
    'FontSize', 11);

set(gca, 'FontSize', 11);

hold off;

%% Reference
% Rizk-Allah, R. M., El-Sehiemy, R. A., & Abdelwanis, M. I. (2024).
% Improved Tasmanian devil optimization algorithm for parameter
% identification of electric transformers.
% Neural Computing and Applications, 36(6), 3141-3166.