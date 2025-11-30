clc; clear; close all;

% Problem Parameters
params.N = 30;           

dim = params.N;
lb  = -5.12 * ones(1, dim);
ub  =  5.12 * ones(1, dim);

% GWO Parameters
SearchAgents = 30;
MaxIter      = 300;

% Run GWO
[gwo_best, gwo_pos, gwo_curve] = GWO(SearchAgents, MaxIter, lb, ub, dim, ...
    @(x) objective(x, params));

% Run IGWO
[igwo_best, igwo_pos, igwo_curve] = IGWO(SearchAgents, MaxIter, lb, ub, dim, ...
    @(x) objective(x, params));

% Run HGWO
[hgwo_best, hgwo_pos, hgwo_curve] = HGWO(SearchAgents, MaxIter, lb, ub, dim, ...
    @(x) objective(x, params));

fprintf("GWO best value:  %.6f\n", gwo_best);
fprintf("IGWO best value: %.6f\n", igwo_best);
fprintf("HGWO best value: %.6f\n", hgwo_best);

% Plot comparison
figure;
plot(gwo_curve, 'LineWidth', 2); hold on;
plot(igwo_curve, 'LineWidth', 2);
plot(hgwo_curve, 'LineWidth', 2);
xlabel("Iteration");
ylabel("Best Fitness");
title("GWO vs IGWO vs HGWO on Rastrigin Function");
legend("GWO", "IGWO", "HGWO");
grid on;
