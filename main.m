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
nb_chain = 30000;
PI1_time = getEstimationPI(chain_1(nb_chain, time, pi0), k);
PI4_time = getEstimationPI(chain_4(nb_chain, time, pi0), k);
%%
% Compute std for each state
time_span = 50;
cut1 = PI1_time(end-time_span+1:end, :);
cut4 = PI4_time(end-time_span+1:end, :);

max_std1 = max(std(cut1, 1)/ sqrt(length(cut1)));
max_std4 = max(std(cut4, 1)/ sqrt(length(cut4)));

PI_est_1 = mean(cut1, 1);
PI_est_4 = mean(cut4, 1);
save('pi_hat_chain_1.mat','PI_est_1');
save('pi_hat_chain_4.mat','PI_est_4');
%%
bar(PI_est_1)
%%
bar(PI_est_4)
%% g)
% chain 1
diff_TV_1 = 0.5 * vecnorm(PI1_time - PI_est_1, 1, 2);
diff_TV_1_1 = 0.5 * vecnorm(getEstimationPI(chain_1(nb_chain, time, 1), k) - PI_est_1, 1, 2);
diff_TV_1_2 = 0.5 * vecnorm(getEstimationPI(chain_1(nb_chain, time, 2), k) - PI_est_1, 1, 2);
diff_TV_1_3 = 0.5 * vecnorm(getEstimationPI(chain_1(nb_chain, time, 3), k) - PI_est_1, 1, 2);
diff_TV_1_4 = 0.5 * vecnorm(getEstimationPI(chain_1(nb_chain, time, 4), k) - PI_est_1, 1, 2);
diff_TV_1_5 = 0.5 * vecnorm(getEstimationPI(chain_1(nb_chain, time, 5), k) - PI_est_1, 1, 2);
% chain 4
diff_TV_4 = 0.5 * vecnorm(PI4_time - PI_est_4, 1, 2);
diff_TV_4_1 = 0.5 * vecnorm(getEstimationPI(chain_4(nb_chain, time, 1), k) - PI_est_4, 1, 2);
diff_TV_4_2 = 0.5 * vecnorm(getEstimationPI(chain_4(nb_chain, time, 2), k) - PI_est_4, 1, 2);
diff_TV_4_3 = 0.5 * vecnorm(getEstimationPI(chain_4(nb_chain, time, 3), k) - PI_est_4, 1, 2);
diff_TV_4_4 = 0.5 * vecnorm(getEstimationPI(chain_4(nb_chain, time, 4), k) - PI_est_4, 1, 2);
diff_TV_4_5 = 0.5 * vecnorm(getEstimationPI(chain_4(nb_chain, time, 5), k) - PI_est_4, 1, 2);
%% chain 1
plot([diff_TV_1_1, diff_TV_1_2, diff_TV_1_3, diff_TV_1_4, diff_TV_1_5, diff_TV_1]);
%% chain 4
plot([diff_TV_4_1, diff_TV_4_2, diff_TV_4_3, diff_TV_4_4, diff_TV_4_5, diff_TV_4]);
%% h)
[~, D, W] = eig(P1);
pi_stat = (W(:, 1) / sum(W(:, 1)))';
bar(pi_stat);

