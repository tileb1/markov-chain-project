%%
% Definition of variables
k = 5;
NB_CHAINS = 10000;
TIME = 50;
pi0 = ones(1, k)/k;
realization = chain_3(NB_CHAINS, TIME, pi0); % change the function for other chain

%% a)
% Plot P values of P over time
count_pij = getPOverTime(realization, k);
plot(2:TIME, reshape(count_pij(:, :, :), [k*k, TIME-1]))

%% c)
% After observing the plots, only 1 and 2 are time homogeneous
time = 100;
nb_chain = 10000;
P1_time = getPOverTime(chain_1(nb_chain, time, pi0), k);
P2_time = getPOverTime(chain_2(nb_chain, time, pi0), k);

max_std_of_mean1 = max(max(std(P1_time, 0, 3) / time)) % max std of average
max_std_of_mean2 = max(max(std(P2_time, 0, 3) / time)) % max std of average

% Compute mean (which is random variable of interest for which we have a
% confidence interval) and save it
P1 = mean(P1_time, 3);
P2 = mean(P2_time, 3);

save('P_hat_chain_1.mat','P1');
save('P_hat_chain_2.mat','P2');
%%
% Plot PI over time
count_s = getEstimationPI(realization, k);
plot(1:TIME, count_s);

%%
% Compute variance of each element
time_span = 50;
cut = count_s(end-time_span:end, :);
std_ = std(cut)
mean_ = mean(cut, 1)