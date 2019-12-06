%%
% Definition of variables
k = 5;
nb_chain = 1.5e6;
time = 200;
pi0 = ones(1, k)/k;
realization = chain_2(nb_chain, time, pi0); % change the function for other chain

%% a)
% Plot P values of P over time
count_pij = getPOverTime(realization, k);
plot(2:time, reshape(count_pij(:, :, :), [k*k, time-1]))

%% c)
% After observing the plots, only 1 and 2 are time homogeneous
P2_time = getPOverTime(chain_2(nb_chain, time, pi0), k);
max_std_of_mean2 = max(max(std(P2_time, 0, 3) / sqrt(time-1))) % (it's time-1 because we get time-1 estimates of thep_{ij}s)

% Compute mean (which is random variable of interest for which we have a
% confidence interval) and save it
P2 = mean(P2_time, 3);

save('P_hat_chain_2.mat','P2');
%% e, f)
% PI over time for plotting (no limiting distribution since aperiodic)
PI2_time = getEstimationPI(chain_2(nb_chain, time, pi0), k);
%%
bar(PI_est_2)
%% h)
[~, D, W] = eig(P2);
pi_stat = (W(:, 1) / sum(W(:, 1)))';
bar(pi_stat);

