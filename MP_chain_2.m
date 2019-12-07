function X = MP_chain_2(N_chain, Time, pi_a, x0)

%Returns a N_chain realisations of the modified version of chain 2 with
%length Time and initial state x0

    load('P_hat_chain_2.mat', 'P2');
    X = zeros(Time, N_chain);
    X(1,:) = chain_2(N_chain,1,x0);
    
    for i = 2:Time
        for j = 1:N_chain
            current = X(i-1,j);
            next = chain_2(1,2,current);
            next = next(2);
            %Compute the probability of acceptance and accept the next
            %state accoding to it
            a = min(1, (pi_a(next)*P2(next, current))/((pi_a(current)*P2(current, next))));
            x = rand;
            if x < a
                X(i,j)=next;
            else
                X(i,j)=current;
            end
        end
    end
    
end