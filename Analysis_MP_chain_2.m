%% b.1) Evaluation of the limiting distribution of the modified chain

Time = 200;
N_chain = 100000;
PI = ones(200,5);

%1. analysis (distribution and total variation distance) for pi_a 1

pia_1 = [16,8,4,2,1]/31;
PI_lim_1 = ones(5,5);
totvar = zeros(1,200);

for x0 = 1:5
    % get the distribution over time
    PI = getEstimationPI(MP_chain_2(N_chain, Time, pia_1, x0), 5);
    
    % compute the total variation distance over time
    A = abs(PI-pia_1);
    A = 0.5* sum(A, 2); 
    
    % plot the distribution over time
    figure(1);
    plot(PI)
    title("Distribution of chain 2 with pi_a 1", 'Interpreter', 'none')
    hold on
    PI_lim_1(x0,:) = PI(200, :);
    
    % plot the total variation distance over time
    figure(2);
    set(gca, 'YScale', 'log')
    plot(transpose(A), 'DisplayName', "X0=" + x0);
    lgd = legend;
    title("Total variation distance of chain 2 with pi_a 1", 'Interpreter', 'none')
    hold on
end
hold off

%2. analysis (distribution and total variation distance) for pi_a 2

figure
pia_2 = [1,1,4,1,1]/8;
PI_lim_2 = ones(5,5);

for x0 = 1:5
    % get the distribution over time    
    PI = getEstimationPI(MP_chain_2(N_chain, Time, pia_2, x0), 5);
    
    % compute the total variation distance over time
    A = abs(PI-pia_2);
    A = 0.5* sum(A, 2); 
    
    % plot the distribution over time    
    figure(3);
    plot(PI)
    title("Distribution of chain 2 with pi_a 2", 'Interpreter', 'none')
    hold on
    PI_lim_2(x0,:) = PI(200, :);
    
    % plot the total variation distance over time with a logarithmic scale
    figure(4);
    set(gca, 'YScale', 'log')
    plot(transpose(A), 'DisplayName', "X0=" + x0);
    lgd = legend;
    title("Total variation distance of chain 2 with pi_a 2", 'Interpreter', 'none')
    hold on
end
hold off

%3. analysis (distribution and total variation distance) for pi_a 3

figure
pia_3 = [4,2,1,2,4]/13;
PI_lim_3 = ones(5,5);

for x0 = 1:5
    
    PI = getEstimationPI(MP_chain_2(N_chain, Time, pia_3, x0), 5);
    A = abs(PI-pia_3);
    A = 0.5* sum(A, 2); 
    figure(5);
    plot(PI)
    title("Distribution of chain 2 with pi_a 3", 'Interpreter', 'none')
    hold on
    PI_lim_3(x0,:) = PI(200, :);
    
    % plot the total variation distance over time with a logarithmic scale
    figure(6);
    set(gca, 'YScale', 'log')
    plot(transpose(A), 'DisplayName', "X0=" + x0);
    lgd = legend;
    title("Total variation distance of chain 2 with pi_a 3", 'Interpreter', 'none')
    hold on
end
hold off