%% b)

pi_a = zeros(3,5);
pi_a(1,:) = [16,8,4,2,1]/31;
pi_a(2,:) = [1,1,4,1,1]/8;
pi_a(3,:) = [4,2,1,2,4]/13;

%% b1)
%For chain 1:
PI1_lim = zeros(5,5);
PI2_lim = zeros(5,5);
PI3_lim = zeros(5,5);
Time = 200;
N_chain = 100000;
for x0 = 1:5
    PI = getEstimationPI(MP_chain_2(N_chain, Time, pi_a3, x0), 5);
    figure
    plot(PI)
    PI1_lim(x0,:) = mean(PI(150:200, :), 1);
end
PI1_lim


%% b2)
totvar = zeros(1,200);
Time = 200;
N_chain = 100;
for i = 1:3
    figure
    hold off
    for x0 = 1:5
        PI = getEstimationPI(MP_chain_2(N_chain, Time, pi_a(i,:), x0), 5);
        A = abs(PI-pi_a(i,:));
        A = 0.5* sum(A, 2);
        plot(transpose(A), 'DisplayName', "intial state "+x0)
        lgd = legend;
        hold on
    end
    title("pi_a " + i)
end

