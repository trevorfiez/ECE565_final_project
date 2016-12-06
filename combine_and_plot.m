function [ ] = combine_and_plot(  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

	alphas = 9;
	trials = 20;
	
	load('EM_alpha_p_q_squared_error_per_trial_p0.2_q0.4_n20_N200_trials20.mat', 'alpha_squared_error_per_trial', 'p_squared_error_per_trial', 'q_squared_error_per_trial');
	load('MOM_alpha_p_q_squared_error_per_trial_p0.2_q0.4_n20_N200_trials20.mat', 'MOM_alpha_squared_error_per_trial', 'MOM_p_squared_error_per_trial', 'MOM_q_squared_error_per_trial');
	
    [junk, junk1, alpha_crlb, p_crlb, q_crlb] = problem_2();

	%EM
	em_alpha_sum_over_trials = sum(alpha_squared_error_per_trial,1);
	em_p_sum_over_trials = sum(p_squared_error_per_trial,1);
	em_q_sum_over_trials = sum(q_squared_error_per_trial,1);
	
	em_mse_alpha = em_alpha_sum_over_trials / trials;
    em_mse_p = em_p_sum_over_trials / trials;
    em_mse_q = em_q_sum_over_trials / trials;
    
    %MOM
    mom_alpha_sum_over_trials = sum(MOM_alpha_squared_error_per_trial,1);
	mom_p_sum_over_trials = sum(MOM_p_squared_error_per_trial,1);
	mom_q_sum_over_trials = sum(MOM_q_squared_error_per_trial,1);
	
	mom_mse_alpha = mom_alpha_sum_over_trials / trials;
    mom_mse_p = mom_p_sum_over_trials / trials;
    mom_mse_q = mom_q_sum_over_trials / trials;

	
	alpha_vals = ones(9, 1);
    for i = 1:alphas
        alpha_vals(i, 1) = i * 0.1;
    end
    
    figure
    title('Comparison of EM and MOM estimators to the CRLB');
    
    subplot(3,1,1)
    lines = plot(alpha_vals, alpha_crlb, alpha_vals, em_mse_alpha, alpha_vals, mom_mse_alpha)
    xlabel('\alpha')
    ylabel('MSE(\alpha)')
%     axis([0.1, 0.9, 0.000002, 0.06])
    
    subplot(3,1,2)
    plot(alpha_vals, p_crlb, alpha_vals, em_mse_p, alpha_vals, mom_mse_p)
    xlabel('\alpha')
    ylabel('MSE(p)')
%     axis([0.1, 0.9, 0.00001, 0.1])

    subplot(3,1,3)
    plot(alpha_vals, q_crlb, alpha_vals, em_mse_q, alpha_vals, mom_mse_q)
    xlabel('\alpha')
    ylabel('MSE(q)')
%     axis([0.1, 0.9, 0.00001, 0.1])
    
    hL = legend([lines(1), lines(2), lines(3)],{'CRLB','EM estimator','MOM estimator'})
    
%     pos = [0.4 0.4 0.2 0.2];
%     newUnits = 'normalized';
%     set(hL, 'Position', pos, 'Units', newUnits);
end

