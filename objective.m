function f = objective(x, params)
    % Rastrigin benchmark function
    % Global minimum = 0 at x = 0

    A = 10;
    N = params.N;

    f = A*N + sum(x.^2 - A * cos(2*pi*x));
end