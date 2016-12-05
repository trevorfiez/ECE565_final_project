
function [  ] = problem_4( )
   
    p = 0.2;
    q = 0.4;
    n = 20;
    N = 20;
    alphas = 9;
    trials = 1;
    
    alpha_squared_error_sum = zeros(alphas, 1);
    p_squared_error_sum = zeros(alphas, 1);
    q_squared_error_sum = zeros(alphas, 1);
    
    real_alpha_vals = ones(alphas, 1);
    
    %Initialize values
    for i = 1:alphas
        real_alpha_vals(i, 1) = i * 0.1;
    end
    
    for a = 1:alphas
        for trial = 1:trials
            bags = get_bags(real_alpha_vals(a, 1) , p, q, n, N);
            [est_p, est_q, est_alpha ] = compute_pq( bags, n, N );
            
            if est_p >= 0 && est_q >= 0 && est_alpha >= 0
                alpha_squared_error_sum(a,1) = alpha_squared_error_sum(a,1) + (est_alpha - real_alpha_vals(a,1))^2;
                p_squared_error_sum(a,1) = p_squared_error_sum(a,1) + (est_p - p)^2;
                q_squared_error_sum(a,1) = q_squared_error_sum(a,1) + (est_q - q)^2;
            end
            
        end
    end
    
    %Print empirical MSE
    all_mse_alpha = zeros(alphas, 1);
    all_p_alpha = zeros(alphas, 1);
    all_q_alpha = zeros(alphas, 1);
    for a = 1:alphas
        mse_alpha = alpha_squared_error_sum(a,1) / trials;
        mse_p = p_squared_error_sum(a,1) / trials;
        mse_q = q_squared_error_sum(a,1) / trials;
        sprintf('MSEs with alpha = %f: alpha:%f, p:%f, q:%f', real_alpha_vals(a,1), mse_alpha, mse_p, mse_q)
        
        all_mse_alpha(a,1) = mse_alpha;
        all_p_alpha(a,1) = mse_p;
        all_q_alpha(a,1) = mse_q;
    end
    
    figure
    subplot(3,1,1)
    plot(real_alpha_vals, all_mse_alpha)
    xlabel('\alpha')
    ylabel('MSE(\alpha)')
%     axis([0.1, 0.9, 0, 1])

    subplot(3,1,2)
    plot(real_alpha_vals, all_p_alpha)
    xlabel('\alpha')
    ylabel('MSE(p)')
%     axis([0.1, 0.9, 0, 1])

    subplot(3,1,3)
    plot(real_alpha_vals, all_q_alpha)
    xlabel('\alpha')
    ylabel('MSE(q)')
%     axis([0.1, 0.9, 0, 1])
end
