function from_a_to_b_smart(dims, a, b, obstacles)
    path = optimal_path(a, b, obstacles);
    for i = 2:size(path,1)
        from_a_to_b_linear(dims, path(i-1,:), path(i,:))
    end
end