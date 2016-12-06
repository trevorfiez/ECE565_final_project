function [FIM_vals, CRLB, alpha_crlb, p_crlb, q_crlb  ] = problem_2( )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    
    p = 0.2;
    q = 0.4;
    n = 20;
    N = 200;
    
%     trials = 200.0;
    
    alpha_vals = ones(9, 1);
    FIM_vals = zeros(9, 3, 3);
    
    for i = 1:9
        alpha_vals(i, 1) = i * 0.1;
    end
    p_other = zeros(9, 1);
    test = FIM_vals(1,:)
    for a = 1:9
        b = compute_FIM(alpha_vals(a, 1), p, q, n, N)
            %c = FIM_vals(a,:,:)
            %d = b
        crlb = inv(b);
        p_other(a, 1) = crlb(2, 2);
        FIM_vals(a,:, :) = b(:, :);
        squeeze(FIM_vals(a, :, :));
            %FIM_vals(a,:) = FIM_vals(a,:) + compute_FIM(alpha_vals(a, 1), p, q, n, N);
        
        
    end
    
    
    for i =1:9
        fim = squeeze(FIM_vals(i, :, :))
    end
    
    CRLB = zeros(9, 3, 3);
    
    for i = 1:9
        %FIM_vals(i, :, :)
        CRLB(i, :, :) = inv(squeeze(FIM_vals(i, :, :)));
    end
    %FIM_vals
    alpha_crlb = zeros(9, 1);
    p_crlb = zeros(9, 1);
    q_crlb = zeros(9, 1);
    for i = 1:9
        alpha_crlb(i, 1) = CRLB(i, 1, 1);
        p_crlb(i, 1) = CRLB(i, 2, 2);
        q_crlb(i, 1) = CRLB(i, 3, 3);
        crlb = squeeze(CRLB(i, :, :));
    end

    figure
    subplot(3,1,1)
    plot(alpha_vals, alpha_crlb)
    xlabel('\alpha')
    ylabel('MSE(\alpha)')
%     axis([0.1, 0.9, 0, 1])
    
    subplot(3,1,2)
    plot(alpha_vals, p_crlb)
    xlabel('\alpha')
    ylabel('MSE(p)')
%     axis([0.1, 0.9, 0, 1])

    subplot(3,1,3)
    plot(alpha_vals, q_crlb)
    xlabel('\alpha')
    ylabel('MSE(q)')
end

