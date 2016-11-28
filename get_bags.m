function [ bags ] = get_bags( alpha, p, q, n, N )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    bags = zeros(N, 1);
    
    for i = 1:N
        num_ones = 0;
        for j = 1:n
            if (rand() < alpha)
                if (rand() < p)
                    num_ones = num_ones + 1;
                end    
            else
                if (rand() < q)
                    num_ones = num_ones + 1;
                end
            end
        end
        bags(i, 1) = num_ones;
    end
    
end

