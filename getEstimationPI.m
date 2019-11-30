function count_s = getEstimationPI(realization, k)
% Returns an estimate of PI given the realisation of the markov chain
    [time, nb_chain] = size(realization);
    count_s = zeros(time, k);
    % Loop over time
    for t=1:time
        % Loop over realizations
        for n=1:nb_chain
            s = realization(t, n);
            count_s(t, s) = count_s(t, s) + 1;
        end
    end
    count_s = count_s / nb_chain;
end

