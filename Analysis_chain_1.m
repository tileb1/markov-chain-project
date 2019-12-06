%%
% Definition of variables
k = 5;
nb_chain = 1.5e6;
time = 200;
pi0 = ones(1, k)/k;
realization = chain_1(nb_chain, time, pi0); % change the function for other chain

%% a)
% Plot P values of P over time
count_pij = getPOverTime(realization, k);
plot(2:time, reshape(count_pij(:, :, :), [k*k, time-1]))

%% c)
% After observing the plots, only 1 and 2 are time homogeneous
P1_time = getPOverTime(chain_1(nb_chain, time, pi0), k);
max_std_of_mean1 = max(max(std(P1_time, 0, 3) / sqrt(time-1))) % (it's time-1 because we get time-1 estimates of thep_{ij}s)

% Compute mean (which is random variable of interest for which we have a
% confidence interval) and save it
P1 = mean(P1_time, 3);

save('P_hat_chain_1.mat','P1');
%% e, f)
% PI over time for plotting
PI1_time = getEstimationPI(chain_1(nb_chain, time, pi0), k);
%%
% Compute limiting distribution
nb_split = 100;

% Chain 1
res1 = chain_1(nb_chain, time, pi0);

% The reshape here under is a trick for calling our function (normally
% taking a matrix as input)
PI1_for_cross_val = getEstimationPI(reshape(res1(end, :), [nb_split, nb_chain / nb_split]), k);
PI_est_1 = mean(PI1_for_cross_val, 1)
std(PI1_for_cross_val, 1) / sqrt(nb_split)
%%
save('pi_hat_chain_1.mat','PI_est_1');
%%
bar(PI_est_1)
%% g)
% chain 1
diff_TV_1 = 0.5 * vecnorm(getEstimationPI(chain_1(nb_chain, time, pi0), k) - PI_est_1, 1, 2);
diff_TV_1_1 = 0.5 * vecnorm(getEstimationPI(chain_1(nb_chain, time, 1), k) - PI_est_1, 1, 2);
diff_TV_1_2 = 0.5 * vecnorm(getEstimationPI(chain_1(nb_chain, time, 2), k) - PI_est_1, 1, 2);
diff_TV_1_3 = 0.5 * vecnorm(getEstimationPI(chain_1(nb_chain, time, 3), k) - PI_est_1, 1, 2);
diff_TV_1_4 = 0.5 * vecnorm(getEstimationPI(chain_1(nb_chain, time, 4), k) - PI_est_1, 1, 2);
diff_TV_1_5 = 0.5 * vecnorm(getEstimationPI(chain_1(nb_chain, time, 5), k) - PI_est_1, 1, 2);
%% chain 1
loglog([diff_TV_1_1, diff_TV_1_2, diff_TV_1_3, diff_TV_1_4, diff_TV_1_5, diff_TV_1]);
hold on;
loglog(1:200, ones(1, 200) * 0.005);
%% h)
[~, D, W] = eig(P1);
pi_stat = (W(:, 1) / sum(W(:, 1)))';
bar(pi_stat);

