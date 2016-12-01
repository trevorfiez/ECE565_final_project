function [ new_alpha, new_p, new_q ] = EM_step( alpha, p, q, n, N, bags )
    
    p_y1 = zeros(N, 1);
    p_y0 = zeros(N, 1);
    
    sum_p_y1 = 0;
    sum_p_y0 = 0;
    
    sum_p_y1_k = 0;
    sum_p_y0_k = 0;
    
    %E-step
    for i = 1:N
        k1i = bags(i, 1);
        
    	binomial_p = binopdf(k1i, n, p);
    	binomial_q = binopdf(k1i, n, q);
    	p_y1(i, 1) = (alpha * binomial_p) / (alpha * binomial_p + (1 - alpha) * binomial_q);
    	p_y0(i, 1) = ( (1 - alpha) * binomial_q) / (alpha * binomial_p + (1 - alpha) * binomial_q);
        
        sum_p_y1 = sum_p_y1 + p_y1(i, 1);
        sum_p_y0 = sum_p_y0 + p_y0(i, 1);
        
        sum_p_y1_k = sum_p_y1_k + (p_y1(i, 1) * k1i);
        sum_p_y0_k = sum_p_y0_k + (p_y0(i, 1) * k1i);
    end
    
    %M-step
    new_alpha = (1 / N) * sum_p_y1;
    new_p = sum_p_y1_k / (n * sum_p_y1);
    new_q = sum_p_y0_k / (n * sum_p_y0);
    
end