function [ ] = problem_4( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    alpha = 0.4;
    p = 0.2;
    q = 0.4;
    n = 20.0;
    N = 20.0;
    
    trials = 200;
    
    
    alpha_vals = ones(9, 1);
    alpha_mse = zeros(9, 1);
    p_mse = zeros(9, 1);
    q_mse = zeros(9, 1);
    total_mse = zeros(9, 1);
    
    for i = 1:9
        alpha_vals(i, 1) = 0.1 * i;
    end
    
    initial_alpha = 0.5;
    for i = 1:9
        for t = 1:trials
            bags = get_bags(alpha_vals(i, 1), p, q, n, N);

            [p_mom, q_mom] = compute_pq(initial_alpha, bags, n, N);

            alpha_mse(i, 1) = alpha_mse(i, 1) + (initial_alpha - alpha_vals(i, 1))^2;
            p_mse(i, 1) = p_mse(i, 1) + (p_mom - p)^2;
            q_mse(i, 1) = q_mse(i, 1) + (q_mom - q)^2;
            

        end
        total_mse(i, 1) = alpha_mse(i, 1) + p_mse(i, 1) + q_mse(i, 1);
    end
    
    p_mse = (1.0 / trials) * p_mse;
    q_mse = (1.0 / trials) * q_mse;
    alpha_mse = (1.0 / trials) * alpha_mse;
    total_mse  = (1.0 / trials) * total_mse;
    
    p_mse
    q_mse
    alpha_mse
    total_mse

end

