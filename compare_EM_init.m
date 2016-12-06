function [ ] = compare_EM_init(  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

	alphas = 9;
	trials = 20;
	
	EM_regular = load('EM_alpha_p_q_squared_error_per_trial_p0.2_q0.4_n20_N200_trials20.mat');
	EM_random = load('EM_random_alpha_p_q_squared_error_per_trial_p0.2_q0.4_n20_N200_trials20.mat');
    EM_exact = load('EM_exact_alpha_p_q_squared_error_per_trial_p0.2_q0.4_n20_N200_trials20.mat');
	
	%EM kmeans
    alpha_squared_error_per_trial = EM_regular.alpha_squared_error_per_trial;
    p_squared_error_per_trial = EM_regular.p_squared_error_per_trial;
    q_squared_error_per_trial = EM_regular.q_squared_error_per_trial;
    
	em_alpha_sum_over_trials = sum(alpha_squared_error_per_trial,1);
	em_p_sum_over_trials = sum(p_squared_error_per_trial,1);
	em_q_sum_over_trials = sum(q_squared_error_per_trial,1);
	
	em_mse_alpha = em_alpha_sum_over_trials / trials;
    em_mse_p = em_p_sum_over_trials / trials;
    em_mse_q = em_q_sum_over_trials / trials;
    
    %EM random
    random_alpha_squared_error_per_trial = EM_random.alpha_squared_error_per_trial;
    random_p_squared_error_per_trial = EM_random.p_squared_error_per_trial;
    random_q_squared_error_per_trial = EM_random.q_squared_error_per_trial;
    
    em_random_alpha_sum_over_trials = sum(random_alpha_squared_error_per_trial,1);
	em_random_p_sum_over_trials = sum(random_p_squared_error_per_trial,1);
	em_random_q_sum_over_trials = sum(random_q_squared_error_per_trial,1);
	
	em_random_mse_alpha = em_random_alpha_sum_over_trials / trials;
    em_random_mse_p = em_random_p_sum_over_trials / trials;
    em_random_mse_q = em_random_q_sum_over_trials / trials;
    
    %EM exact
    exact_alpha_squared_error_per_trial = EM_exact.alpha_squared_error_per_trial;
    exact_p_squared_error_per_trial = EM_exact.p_squared_error_per_trial;
    exact_q_squared_error_per_trial = EM_exact.q_squared_error_per_trial;
    
    em_exact_alpha_sum_over_trials = sum(exact_alpha_squared_error_per_trial,1);
	em_exact_p_sum_over_trials = sum(exact_p_squared_error_per_trial,1);
	em_exact_q_sum_over_trials = sum(exact_q_squared_error_per_trial,1);
	
	em_exact_mse_alpha = em_exact_alpha_sum_over_trials / trials;
    em_exact_mse_p = em_exact_p_sum_over_trials / trials;
    em_exact_mse_q = em_exact_q_sum_over_trials / trials;

	
	alpha_vals = ones(9, 1);
    for i = 1:alphas
        alpha_vals(i, 1) = i * 0.1;
    end
    
    figure
    title('Comparison of EM initialization methods.');
    
    subplot(3,1,1)
    lines = plot(alpha_vals, em_mse_alpha, alpha_vals, em_random_mse_alpha, alpha_vals, em_exact_mse_alpha)
    xlabel('\alpha')
    ylabel('MSE(\alpha)')
%     axis([0.1, 0.9, 0.000002, 0.06])
    
    subplot(3,1,2)
    plot(alpha_vals, em_mse_p, alpha_vals, em_random_mse_p, alpha_vals, em_exact_mse_p)
    xlabel('\alpha')
    ylabel('MSE(p)')
%     axis([0.1, 0.9, 0.00001, 0.1])

    subplot(3,1,3)
    plot(alpha_vals, em_mse_q, alpha_vals, em_random_mse_q, alpha_vals, em_exact_mse_q)
    xlabel('\alpha')
    ylabel('MSE(q)')
%     axis([0.1, 0.9, 0.00001, 0.1])
    
    hL = legend([lines(1), lines(2), lines(3)],{'K-Means','Random','Exact'})
    
%     pos = [0.4 0.4 0.2 0.2];
%     newUnits = 'normalized';
%     set(hL, 'Position', pos, 'Units', newUnits);
end

