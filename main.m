%%
% Definition of variables
k = 5;
NB_CHAINS = 60000;
TIME = 150;
pi0 = ones(1, k)/k;
realization = chain_4(NB_CHAINS, TIME, pi0);

%%
% Plot P values of P over time
count_pij = getPOverTime(realization, k);
plot(2:TIME, reshape(count_pij(:, :, :), [k*k, TIME-1]))

%%
% Plot PI over time
count_s = getEstimationPI(realization, k);
plot(1:TIME, count_s);