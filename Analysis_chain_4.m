%%
% Definition of variables
k = 5;
nb_chain = 1.5e6;
time = 200;
pi0 = ones(1, k)/k;
realization = chain_4(nb_chain, time, pi0); % change the function for other chain

%% a)
% Plot P values of P over time
count_pij = getPOverTime(realization, k);
plot(2:time, reshape(count_pij(:, :, :), [k*k, time-1]))

%% e)
% PI over time for plotting
PI4_time = getEstimationPI(chain_4(nb_chain, time, pi0), k);