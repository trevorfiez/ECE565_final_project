function [  ] = problem_2( )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    
    p = 0.2;
    q = 0.4;
    n = 20;
    N = 20;
    
    alpha_vals = ones(9, 1);
    FIM_vals = zeros(9, 1);
    
    for i = 1:9
        alpha_vals(i, 1) = i * 0.1;
    end
    
    for a = 1:9
        for trial = 1:200
            FIM_vals(a, 1) = FIM_vals(a, 1) + compute_FIM(alpha_vals(a, 1), p, q, n, N);
        end
    end
    
    FIM_vals = (1 / 200.0) * FIM_vals;
    FIM_vals

end

