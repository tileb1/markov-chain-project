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

max_std_of_mean1 = max(max(std(P1_time, 0, 3) / sqrt(time-1))) % max std of average
max_std_of_mean2 = max(max(std(P2_time, 0, 3) / sqrt(time-1))) % max std of average

% Compute mean (which is random variable of interest for which we have a
% confidence interval) and save it
P1 = mean(P1_time, 3);
P2 = mean(P2_time, 3);

save('P_hat_chain_1.mat','P1');
save('P_hat_chain_2.mat','P2');
%% f) TODO
% Plot PI over time
time = 200;
nb_chain = 1000000;
PI1_time = getEstimationPI(chain_1(nb_chain, time, pi0), k);
PI4_time = getEstimationPI(chain_4(nb_chain, time, pi0), k);
%%
% Compute limiting distribution
nb_chain = 1500000;
nb_split = 100;

% Chain 1
res1 = chain_1(nb_chain, time, pi0);
bootstrappedPI1 = getEstimationPI(reshape(res1(end, :), [nb_split, nb_chain / nb_split]), k);
PI_est_1 = mean(bootstrappedPI1, 1)
std(bootstrappedPI1, 1) / sqrt(nb_split)

% Chain 4
res4 = chain_4(nb_chain, time, pi0);
bootstrappedPI4 = getEstimationPI(reshape(res4(end, :), [nb_split, nb_chain / nb_split]), k);
PI_est_4 = mean(bootstrappedPI4, 1)
std(bootstrappedPI4, 1) / sqrt(nb_split)
%%
save('pi_hat_chain_1.mat','PI_est_1');
save('pi_hat_chain_4.mat','PI_est_4');
%%

%%
bar(PI_est_1)
%%
bar(PI_est_4)
%% g)
% chain 1
nb_chain = 1000000; % set to 1000000 for real plot
diff_TV_1 = 0.5 * vecnorm(res1 - PI_est_1, 1, 2);
diff_TV_1_1 = 0.5 * vecnorm(getEstimationPI(chain_1(nb_chain, time, 1), k) - PI_est_1, 1, 2);
diff_TV_1_2 = 0.5 * vecnorm(getEstimationPI(chain_1(nb_chain, time, 2), k) - PI_est_1, 1, 2);
diff_TV_1_3 = 0.5 * vecnorm(getEstimationPI(chain_1(nb_chain, time, 3), k) - PI_est_1, 1, 2);
diff_TV_1_4 = 0.5 * vecnorm(getEstimationPI(chain_1(nb_chain, time, 4), k) - PI_est_1, 1, 2);
diff_TV_1_5 = 0.5 * vecnorm(getEstimationPI(chain_1(nb_chain, time, 5), k) - PI_est_1, 1, 2);
%% chain 4
diff_TV_4 = 0.5 * vecnorm(res4 - PI_est_4, 1, 2);
diff_TV_4_1 = 0.5 * vecnorm(getEstimationPI(chain_4(nb_chain, time, 1), k) - PI_est_4, 1, 2);
diff_TV_4_2 = 0.5 * vecnorm(getEstimationPI(chain_4(nb_chain, time, 2), k) - PI_est_4, 1, 2);
diff_TV_4_3 = 0.5 * vecnorm(getEstimationPI(chain_4(nb_chain, time, 3), k) - PI_est_4, 1, 2);
diff_TV_4_4 = 0.5 * vecnorm(getEstimationPI(chain_4(nb_chain, time, 4), k) - PI_est_4, 1, 2);
diff_TV_4_5 = 0.5 * vecnorm(getEstimationPI(chain_4(nb_chain, time, 5), k) - PI_est_4, 1, 2);
%% chain 1
loglog([diff_TV_1_1, diff_TV_1_2, diff_TV_1_3, diff_TV_1_4, diff_TV_1_5, diff_TV_1]);
hold on;
loglog(1:200, ones(1, 200) * 0.005);
%% chain 4
plot([diff_TV_4_1, diff_TV_4_2, diff_TV_4_3, diff_TV_4_4, diff_TV_4_5, diff_TV_4]);
%% h)
[~, D, W] = eig(P1);
pi_stat = (W(:, 1) / sum(W(:, 1)))';
bar(pi_stat);

