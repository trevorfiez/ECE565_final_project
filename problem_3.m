function [  ] = problem_3( )

    p = 0.2;
    q = 0.4;
    n = 20;
    N = 20;
    
    alphas = 9;
    trials = 200;
    
    alpha_vals = ones(alphas, 1);
    p_vals = zeros(alphas, 1);
    q_vals = zeros(alphas, 1);
    
    real_alpha_vals = ones(alphas, 1);
    
    alpha_squared_error_sum = zeros(alphas, 1);
    p_squared_error_sum = zeros(alphas, 1);
    q_squared_error_sum = zeros(alphas, 1);
    
    all_bags = [];
    
    %Initialize values
    for i = 1:alphas
        real_alpha_vals(i, 1) = i * 0.1;
        
        alpha_vals(i, 1) = rand();
        p_vals(i, 1) = rand();
        q_vals(i, 1) = rand();
        
        all_bags = cat(2, all_bags, get_bags(real_alpha_vals(i, 1), p, q, n, N));
    end
    
    for a = 1:alphas
        for trial = 1:trials
            %Run EM
            [alpha_vals(a, 1), p_vals(a, 1), q_vals(a, 1)] = EM_step(alpha_vals(a, 1), p_vals(a, 1), q_vals(a, 1), n, N, all_bags(:, a));
            
            %Compute MSE
            alpha_squared_error_sum(a,1) = alpha_squared_error_sum(a,1) + (alpha_vals(a, 1) - real_alpha_vals(a,1))^2;
            p_squared_error_sum(a,1) = p_squared_error_sum(a,1) + (p_vals(a, 1) - p)^2;
            q_squared_error_sum(a,1) = q_squared_error_sum(a,1) + (q_vals(a, 1) - q)^2;
        end
    end
    
    %Print empirical MSE
    for a = 1:alphas
        mse_alpha = alpha_squared_error_sum(a,1) / trials;
        mse_p = p_squared_error_sum(a,1) / trials;
        mse_q = q_squared_error_sum(a,1) / trials;
        sprintf('MSEs with alpha = %f: alpha:%f, p:%f, q:%f', real_alpha_vals(a,1), mse_alpha, mse_p, mse_q)
    end
    
    
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


