function [ FIM ] = compute_FIM( alpha, p, q, n, N )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    %{
    bags = get_bags(alpha, p, q, n, N);
    
    df_dtheta = zeros(3, 1);
    %}
    FIM = zeros(3,3);
    for k = 0:n
        
        bottom = (alpha * p0(k, p, n) + (1 - alpha) * p0(k, q, n)) ^ 2;
        aa = (p0(k, p, n) - p0(k, q, n))^2;
        aa = - N * (aa / bottom);
        ap = p1(k, p, n) * p0(k, q, n);
        ap = N * (ap / bottom);
        aq = - p0(k, p, n) * p1(k, q, n);
        aq = N * (aq / bottom);
        
        pp = alpha ^ 2 * p2(k, p, n) * p0(k, p, n) + alpha * (1 - alpha) * p2(k, p, n) * p0(k, q, n) ...
           - alpha^2 * p1(k, p, n)^2;
        pp = N * (pp / bottom);
        pq = -alpha * p1(k, p, n) * (1 - alpha) * p1(k, q, n);
        pq = N * (pq / bottom);
        
        qq = alpha * (1 - alpha) * p2(k, q, n) * p0(k, p, n) + (1 - alpha) ^ 2 * p2(k, q, n) * p0(k, q, n) ...
            - (1 - alpha) ^ 2 * p1(k, q, n) ^ 2;
        qq = N * (qq / bottom);
        
        FIM(1, 1) = FIM(1, 1) + aa;
        FIM(1, 2) = FIM(1, 2) + ap;
        FIM(2, 1) = FIM(1, 2);
        FIM(1, 3) = FIM(1, 3) + aq;
        FIM(3, 1) = FIM(1, 3);
        FIM(2, 2) = FIM(2, 2) + pp;
        FIM(2, 3) = FIM(2, 3) + pq;
        FIM(3, 2) = FIM(2, 3);
        
        FIM(3, 3) = FIM(3, 3) + qq;
    end
    
    FIM = - FIM;
    %{
    for i = 1:N
        b = nchoosek(n, bags(i, 1));
        k1i = bags(i, 1);
        
        base = alpha * b * (p ^ k1i) * ((1 - p)^(n - k1i)) + (1 - alpha) * b * (q ^ k1i) * ((1- q) ^ (n - k1i));
        
        df_dtheta(1, 1) = df_dtheta(1, 1) + (b * (p ^ k1i) * ((1 - p)^(n - k1i)) - b * (q ^ k1i) * ((1- q) ^ (n - k1i))) / base;
        %df_dtheta(1, 1) = df_dtheta(1, 1) ;
        
        df_dtheta(2, 1) = df_dtheta(2, 1) + (alpha * b * (k1i * (p ^ (k1i - 1) * (1 - p) ^ (n - k1i)) - (n - k1i) * (p ^ (k1i)) * (1 - p) ^ (n - k1i - 1))) / base;
        df_dtheta(3, 1) = df_dtheta(3, 1) + ((1 - alpha) * b *(k1i * q ^ (k1i - 1) * (1 - q) ^ (n - k1i) - (n - k1i) * q^k1i * (1- q)^(n - k1i - 1))) / base;
        
    end
    
    FIM = df_dtheta * df_dtheta.';
    df_dtheta.';
    df_dtheta;
    FIM;
    %}
end

