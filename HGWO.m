function [Alpha_score, Alpha_pos, Convergence_curve] = HGWO(SearchAgents_no, Max_iter, lb, ub, dim, fobj)

    % Set up alpha, beta, delta
    Alpha_pos = zeros(1, dim);  Alpha_score = inf;
    Beta_pos  = zeros(1, dim);  Beta_score  = inf;
    Delta_pos = zeros(1, dim);  Delta_score = inf;

    % Set up all positions
    Positions = rand(SearchAgents_no, dim) .* (ub - lb) + lb;

    % PSO parameters
    Vel = zeros(SearchAgents_no, dim);
    w  = 0.3;      
    c1 = 0.5;
    c2 = 0.5;
    Vmax = 0.2 * (ub - lb);

    Convergence_curve = zeros(1, Max_iter);

    for t = 1:Max_iter

        for i = 1:SearchAgents_no
            Positions(i,:) = max(Positions(i,:), lb);
            Positions(i,:) = min(Positions(i,:), ub);

            fitness = fobj(Positions(i,:));

            if fitness < Alpha_score
                Delta_score = Beta_score; Delta_pos = Beta_pos;
                Beta_score  = Alpha_score; Beta_pos  = Alpha_pos;
                Alpha_score = fitness;     Alpha_pos = Positions(i,:);

            elseif fitness < Beta_score
                Delta_score = Beta_score; Delta_pos = Beta_pos;
                Beta_score  = fitness;    Beta_pos  = Positions(i,:);

            elseif fitness < Delta_score
                Delta_score = fitness;    Delta_pos = Positions(i,:);
            end
        end

        % GWO parameter
        a = 2 * (1 - (t / Max_iter) ^ 2);

        for i = 1:SearchAgents_no
            for j = 1:dim

                % GWO update
                r1 = rand(); r2 = rand();
                A1 = 2*a*r1 - a; C1 = 2*r2;
                X1 = Alpha_pos(j) - A1 * abs(C1*Alpha_pos(j) - Positions(i,j));

                r1 = rand(); r2 = rand();
                A2 = 2*a*r1 - a; C2 = 2*r2;
                X2 = Beta_pos(j) - A2 * abs(C2*Beta_pos(j) - Positions(i,j));

                r1 = rand(); r2 = rand();
                A3 = 2*a*r1 - a; C3 = 2*r2;
                X3 = Delta_pos(j) - A3 * abs(C3*Delta_pos(j) - Positions(i,j));

                GWO_pos = (X1 + X2 + X3) / 3;

                % PSO update
                r1 = rand(); r2 = rand();
                Vel(i,j) = w*Vel(i,j) ...
                         + c1*r1*(Alpha_pos(j) - Positions(i,j)) ...
                         + c2*r2*(Beta_pos(j)  - Positions(i,j));

                Vel(i,j) = max(min(Vel(i,j), Vmax(j)), -Vmax(j));

                Positions(i,j) = GWO_pos + 0.1 * Vel(i,j);  % chỉ thêm PSO 10%
            end

            % bound
            Positions(i,:) = max(Positions(i,:), lb);
            Positions(i,:) = min(Positions(i,:), ub);
        end

        Convergence_curve(t) = Alpha_score;
    end
end
