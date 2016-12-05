function [ prob ] = p2( k1, p, n )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    b = nchoosek(n, k1);
    
    prob = k1 * (k1 - 1) * p ^ (k1 - 2) * (1 - p) ^ (n - k1);
    prob = prob + 2 * (n - k1) * k1 * p ^ (k1 - 1) * (1 - p) ^ (n - k1 - 1);
    prob = prob + (n - k1) * (n - k1 - 1) * p ^ k1 * (1 - p) ^ (n - k1 - 2);
    
    prob = prob * b;

end

