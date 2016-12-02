function [ p, q, alpha ] = compute_pq(  bags, n, N )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    k1_bar = 0.0;
    k1_sq_bar = 0.0;
    k1_cb_bar = 0.0;
    
    for i = 1:N
        k1_bar = k1_bar + bags(i, 1);
        k1_sq_bar = k1_sq_bar + (bags(i, 1)^ 2);
        k1_cb_bar = k1_cb_bar + (bags(i, 1)^ 3);
    end
    
    k1_bar = k1_bar / N;
    k1_sq_bar = k1_sq_bar / N;
    k1_cb_bar = k1_cb_bar / N;
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
%     a = (n^2 - n + alpha * n - alpha * n^2 - (1 / alpha) * (1 - alpha) ^ 2 * n + (1 / alpha) * (1 - alpha) ^ 2 * n ^ 2);
%     b = n - alpha * n - (1 - alpha) * n + (2 / alpha) * k1_bar * (1 - alpha) - (2 / alpha) * k1_bar * (1 - alpha) * n;
%     c = -k1_sq_bar + k1_bar - (1 / (alpha * n)) * k1_bar ^ 2 + (1 / alpha) * k1_bar ^ 2;
%     
%     r = roots([a b c]);
%     
%     q = max(r);
%     
%     p_num = k1_bar - ((1 - alpha) * n * q);
%     p_denom = n * alpha;
%     
%     p = p_num / p_denom;
    
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
    
    
    syms p q est_alpha
%     [solp,solq] = solve(alpha * n * p + (1-alpha) * n * q - k1_bar == 0, q^2*(n^2 - n - alpha*n^2 + alpha * n) + q*(n - alpha*n) + alpha * n * p * (1-p) + n*2*p^2 - k1_sq_bar == 0);
    [solp,solq,solalpha] = solve([est_alpha * n * p + (1-est_alpha) * n * q - k1_bar == 0,...
        q^2*(n^2 - n - est_alpha*n^2 + est_alpha * n) + q*(n - est_alpha*n) + est_alpha * n * p * (1-p) + n*2*p^2 - k1_sq_bar == 0,...
        est_alpha*(n*(n-1)*(n-2)*p^3 + 3*n*(n-1)*p^2+n*p) + (1-est_alpha)*(n*(n-1)*(n-2)*q^3 + 3*n*(n-1)*q^2+n*q) == k1_cb_bar],...
        [p, q, est_alpha]);
%     vpa(solp)
%     vpa(solq)
%     vpa(solalpha)

    solp = vpa(solp);
    solq = vpa(solq);
    solalpha = vpa(solalpha);
    
    alpha = -1;
    p = -1;
    q = -1;
    for i = 1:size(solp)
        %Keep solution only if numbers are real and between 0 and 1
        if isreal(solp(i)) && isreal(solq(i)) && isreal(solalpha(i)) && ...
                (solp(i) > 0) && (solp(i) < 1) && (solq(i) > 0) && (solq(i) < 1) && (solalpha(i) > 0) && (solalpha(i) < 1)
            
            p = vpa(solp(i));
            q = vpa(solq(i));
            alpha = vpa(solalpha(i));
            
            if p > q
                alpha = 1 - alpha;
                temp = p;
                p = q;
                q = temp;
            end
            
            break;
        end
    end
    

    
    
%     ezplot(alpha * n * p + (1-alpha) * n * q - k1_bar == 0); hold on;
%     ezplot(q^2*(n^2 - n - alpha*n^2 + alpha * n) + q*(n - alpha*n) + alpha * n * p * (1-p) + n*2*p^2 - k1_sq_bar == 0); 
    
%     if ~isreal(solq(1)) || ~isreal(solq(2))
%         solq(1)
%         solq(2)
%     end
        

%     p = vpa((k1_bar - (1-alpha) * n * solq(1)) / (alpha * n))
%     q = vpa(solq(1))
%     
%     p = vpa((k1_bar - (1-alpha) * n * solq(2)) / (alpha * n))
%     q = vpa(solq(2))
    
    
end

