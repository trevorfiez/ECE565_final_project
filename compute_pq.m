function [ p, q ] = compute_pq( alpha, bags, n, N )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    k1_bar = 0.0;
    k1_sq_bar = 0.0;
    
    for i = 1:N
        k1_bar = k1_bar + bags(i, 1);
        k1_sq_bar = k1_sq_bar + (bags(i, 1)^ 2);
        
    end
    
    k1_bar = k1_bar / N;
    k1_sq_bar = k1_sq_bar / N;
    %{
    a = -2 * (((1 - alpha) ^ 2) * n)
    b = (2 * k1_bar * (1 - alpha)) - (alpha * ( 1 - alpha) * n) + (((1 - alpha) ^ 2) * n)
    c = (-(1 / n) * (k1_bar ^ 2)) + (alpha * k1_bar) - k1_sq_bar + (k1_bar ^ 2)    
    
    a = -2 * (((alpha) ^ 2) * n)
    b = (2 * k1_bar * (alpha)) - (alpha * ( 1 - alpha) * n) + (((alpha) ^ 2) * n)
    c = (-(1 / n) * (k1_bar ^ 2)) + ((1 - alpha) * k1_bar) - k1_sq_bar + (k1_bar ^ 2)    
    
    r = roots([a b c])
    
    p = r(1)
    q = r(2)
    
    %num = k1_sq_bar - (alpha * k1_bar) - k1_bar^2 - ((k1_bar^2) / n)
    %denom = (-2 * k1_bar * (1 - alpha)) - (alpha * (1 - alpha) *n) + (((1 - alpha) ^ 2) * n)
    
    %q = num / denom
    
    q = 0.4
    p_num = k1_bar - ((1 - alpha) * n * q);
    p_denom = n * alpha;
    
    
    p = p_num / p_denom

   
    a = (- alpha * n)
    b = (alpha * n)
    c = (1 - alpha) * n * q * (1 - q) - k1_sq_bar + k1_bar^2
    
    %}
    a = (n^2 - n + alpha * n - alpha * n^2 - (1 / alpha) * (1 - alpha) ^ 2 * n + (1 / alpha) * (1 - alpha) ^ 2 * n ^ 2);
    b = n - alpha * n - (1 - alpha) * n + (2 / alpha) * k1_bar * (1 - alpha) - (2 / alpha) * k1_bar * (1 - alpha) * n;
    c = -k1_sq_bar + k1_bar - (1 / (alpha * n)) * k1_bar ^ 2 + (1 / alpha) * k1_bar ^ 2;
    
    r = roots([a b c]);
    
    q = max(r);
    
    p_num = k1_bar - ((1 - alpha) * n * q);
    p_denom = n * alpha;
    
    p = p_num / p_denom;
    
    %{
    k1_bar = k1_bar
    k1_sq_bar = k1_sq_bar
    sq = alpha * (n*p*(1 - p) + n^2 * p^2) + (1 - alpha) * (n * q * ( 1- q) + n^2 * q^2)
    
    mean = n * (alpha * p + (1 - alpha) * q) 
    q = r(2)
    
    p_num = k1_bar - ((1 - alpha) * n * q);
    p_denom = n * alpha;
    
    p = p_num / p_denom
    
    k1_bar = k1_bar
    k1_sq_bar = k1_sq_bar
    sq = alpha * (n*p*(1 - p) + n^2 * p^2) + (1 - alpha) * (n * q * ( 1- q) + n^2 * q^2)
    mean = n * (alpha * p + (1 - alpha) * q) 
    %}
    
    
end

