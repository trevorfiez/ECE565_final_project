function [ ] = create_plot(  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    [junk, junk1, alpha_crlb, p_crlb, q_crlb] = problem_2();

    [alpha_em, p_em, q_em] = problem_3();

    alpha_vals = ones(9, 1);
   
    for i = 1:9
        alpha_vals(i, 1) = i * 0.1;
    end
    
    figure
    legend('EM empirical MSE', 'CRLB')
    subplot(3,1,1)
    plot(alpha_vals, alpha_em, alpha_vals, alpha_crlb)
    xlabel('\alpha')
    ylabel('MSE(\alpha)')
%     axis([0.1, 0.9, 0, 1])
    
    subplot(3,1,2)
    plot(alpha_vals, p_em, alpha_vals, p_crlb)
    %plot()
    xlabel('\alpha')
    ylabel('MSE(p)')
%     axis([0.1, 0.9, 0, 1])

    subplot(3,1,3)
    plot(alpha_vals, q_em, alpha_vals, q_crlb)
    %plot(alpha_vals, q_crlb)
    xlabel('\alpha')
    ylabel('MSE(q)')

end

