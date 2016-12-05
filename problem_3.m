function [all_mse_alpha, all_p_alpha, all_q_alpha  ] = problem_3( )

    %p must be < q (used to compute MSE later)
    p = 0.2;
    q = 0.4;
    n = 20;
    N = 20;
    
    alphas = 9;
    trials = 10;
    
    alpha_vals = ones(alphas, 1);
    p_vals = zeros(alphas, 1);
    q_vals = zeros(alphas, 1);
    
    real_alpha_vals = ones(alphas, 1);
    
    alpha_squared_error_sum = zeros(alphas, 1);
    p_squared_error_sum = zeros(alphas, 1);
    q_squared_error_sum = zeros(alphas, 1);
    
    %Initialize values
    for i = 1:alphas
        real_alpha_vals(i, 1) = i * 0.1;
    end
    
    for a = 1:alphas
        for trial = 1:trials
            
            %Initialize randomly (trials should be independent)
            alpha_vals(a, 1) = rand();
            p_vals(a, 1) = rand();
            q_vals(a, 1) = rand();
            
            bags = get_bags(real_alpha_vals(a, 1) , p, q, n, N);
            
            %Run EM
            for em_its = 0:200
                [alpha_vals(a, 1), p_vals(a, 1), q_vals(a, 1)] = EM_step(alpha_vals(a, 1), p_vals(a, 1), q_vals(a, 1), n, N, bags);
            end
            
            %Compute MSE
            alpha_iteration = alpha_vals(a, 1);
            p_iteration = p_vals(a, 1);
            q_iteration = q_vals(a, 1);
            %Force estimated p to be less than estimated q
            if p_vals(a, 1) > q_vals(a, 1)
                alpha_iteration = 1 - alpha_vals(a, 1);
                p_iteration = q_vals(a, 1);
                q_iteration = p_vals(a, 1);
            end
     
            alpha_squared_error_sum(a,1) = alpha_squared_error_sum(a,1) + (alpha_iteration - real_alpha_vals(a,1))^2;
            p_squared_error_sum(a,1) = p_squared_error_sum(a,1) + (p_iteration - p)^2;
            q_squared_error_sum(a,1) = q_squared_error_sum(a,1) + (q_iteration - q)^2;
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
    
    
%     aa = 0.1;
%     pp = 0.1;
%     qq = 0.1;
%     bags = get_bags(0.4, 0.2, 0.4, n, N);
%     for trial = 1:trials
%         [aa, pp, qq] = EM_step(aa, pp, qq, n, N, bags);
%     end
%     aa
%     pp
%     qq
    
end


