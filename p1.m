function [ prob ] = p1( k1, p, n )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    b = nchoosek(n, k1);
    
    prob = k1 * p ^ (k1 - 1) * (1 - p)^(n - k1);
    prob = prob + (n - k1) * p ^ k1 * (1 - p) ^ (n - k1 - 1);
    prob = prob * b;

end

