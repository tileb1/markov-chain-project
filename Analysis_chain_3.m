%%
% Definition of variables
k = 5;
nb_chain = 1.5e6;
time = 200;
pi0 = ones(1, k)/k;
realization = chain_3(nb_chain, time, pi0); % change the function for other chain

%% a)
% Plot P values of P over time
count_pij = getPOverTime(realization, k);
plot(2:time, reshape(count_pij(:, :, :), [k*k, time-1]))

%% e, f)
% PI over time for plotting
PI3_time = getEstimationPI(chain_3(nb_chain, time, pi0), k);
%%
% Compute limiting distribution
nb_split = 100;

% Chain 1
res3 = chain_3(nb_chain, time, pi0);

% The reshape here under is a trick for calling our function (normally
% taking a matrix as input)
PI3_for_cross_val = getEstimationPI(reshape(res3(end, :), [nb_split, nb_chain / nb_split]), k);
PI_est_3 = mean(PI3_for_cross_val, 1)
std(PI3_for_cross_val, 1) / sqrt(nb_split)
%%
save('pi_hat_chain_3.mat','PI_est_3');
%%
bar(PI_est_3)
%% g)
% TV norm
diff_TV_3 = 0.5 * vecnorm(getEstimationPI(chain_3(nb_chain, time, pi0), k) - PI_est_3, 1, 2);
diff_TV_3_1 = 0.5 * vecnorm(getEstimationPI(chain_3(nb_chain, time, 1), k) - PI_est_3, 1, 2);
diff_TV_3_2 = 0.5 * vecnorm(getEstimationPI(chain_3(nb_chain, time, 2), k) - PI_est_3, 1, 2);
diff_TV_3_3 = 0.5 * vecnorm(getEstimationPI(chain_3(nb_chain, time, 3), k) - PI_est_3, 1, 2);
diff_TV_3_4 = 0.5 * vecnorm(getEstimationPI(chain_3(nb_chain, time, 4), k) - PI_est_3, 1, 2);
diff_TV_3_5 = 0.5 * vecnorm(getEstimationPI(chain_3(nb_chain, time, 5), k) - PI_est_3, 1, 2);
%% Plots
loglog([diff_TV_3_1, diff_TV_3_2, diff_TV_3_3, diff_TV_3_4, diff_TV_3_5, diff_TV_3]);
hold on;
loglog(1:200, ones(1, 200) * 0.005);
