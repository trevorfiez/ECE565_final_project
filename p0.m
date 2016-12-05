function [ prob ] = p0( k1, p, n )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    b = nchoosek(n, k1);
    
    prob = b * p ^ k1 * (1 - p) ^ (n - k1);

end

