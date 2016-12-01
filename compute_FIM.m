function [ FIM ] = compute_FIM( alpha, p, q, n, N )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    bags = get_bags(alpha, p, q, n, N);
    
    df_dtheta = zeros(3, 1);
    base = 0;
    for i = 1:N
        b = nchoosek(n, bags(i, 1));
        k1i = bags(i, 1);
        base = base + alpha * b * (p ^ k1i) * ((1 - p)^(n - k1i));
        base = base + (1 - alpha) * b * (q ^ k1i) * ((1- q) ^ (n - k1i));
        df_dtheta(1, 1) = df_dtheta(1, 1) + b * (p ^ k1i) * ((1 - p)^(n - k1i));
        df_dtheta(1, 1) = df_dtheta(1, 1) - b * (q ^ k1i) * ((1- q) ^ (n - k1i));
        stuff = alpha * b * ((k1i * (p ^ (k1i - 1))) - (n * (p ^ (n - 1))));
        
        df_dtheta(2, 1) = df_dtheta(2, 1) + alpha * b * (k1i * (p ^ (k1i - 1) * (1 - p) ^ (n - k1i)) + (n - k1i) * (p ^ (k1i)) * (1 - p) ^ (n - k1i - 1));
        df_dtheta(3, 1) = df_dtheta(3, 1) + (1 - alpha) * b *(k1i *(q ^ (k1i - 1) * (1 - q) ^ (n - k1i)) + (1 - alpha) * (n - k1i) * q^k1i * (1- q)^(n - k1i));
        
    end
    base;
    df_dtheta;
    df_dtheta = (1 / base) * df_dtheta;
    df_dtheta;
    %FIM = 0
    FIM = df_dtheta.' * df_dtheta;
    df_dtheta.';
    df_dtheta;
    FIM;
end

