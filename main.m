%%
k = 5;
NB_CHAINS = 60000;
TIME = 50;
pi0 = ones(1, k)/k;
realization = chain_4(NB_CHAINS, TIME, pi0);
count = zeros(k, k, TIME-1);

for t=2:TIME
    % Count number of occurences
    for n=1:NB_CHAINS
        from = realization(t-1, n);
        to = realization(t, n);
        count(from, to, t-1) = count(from, to, t-1) + 1;
    end
    
    % Normalize each distribution (5 of them)
    for i=1:5
        count(i, :, t-1) = count(i, :, t-1) / sum(count(i, :, t-1));
    end
end
plot(2:TIME, reshape(count(:, :, :), [k*k, TIME-1]))