function count_pij = getPOverTime(realization, k)
% Returns a dimension 3 tensor representing the estimated transition
% matrix of time.
    [time, nb_chain] = size(realization);
    count_pij = zeros(k, k, time-1);
    for t=2:time
        % Count number of occurences
        for n=1:nb_chain
            from = realization(t-1, n);
            to = realization(t, n);
            count_pij(from, to, t-1) = count_pij(from, to, t-1) + 1;
        end

        % Normalize each distribution (5 of them)
        for i=1:5
            count_pij(i, :, t-1) = count_pij(i, :, t-1) / sum(count_pij(i, :, t-1));
        end
    end
end

