



%%% Designed and Developed by Mohammad Dehghani, Štěpán Hubálovský, and Pavel Trojovský %%%


function[Best_score,Best_pos,TDO_curve]=TDO(SearchAgents,Max_iterations,lowerbound,upperbound,dimension,fitness)

lowerbound=ones(1,dimension).*(lowerbound);                              % Lower limit for variables
upperbound=ones(1,dimension).*(upperbound);                              % Upper limit for variables

%% INITIALIZATION
for i=1:dimension
    X(:,i) = lowerbound(i)+rand(SearchAgents,1).*(upperbound(i) - lowerbound(i));                          % Initial population
end

for i =1:SearchAgents
    L=X(i,:);
    fit(i)=fitness(L);
end
%%

for t=1:Max_iterations
    %% update the global best (fbest)
    [best , location]=min(fit);
    if t==1
        Xbest=X(location,:);                                           % Optimal location
        fbest=best;                                           % The optimization objective function
    elseif best<fbest
        fbest=best;
        Xbest=X(location,:);
    end
    
    %% PHASE1: Hunting Feeding
    for i=1:SearchAgents
        
        %%
        Pr=rand;
        if Pr>0.5
            %% STRATEGY 1: FEEDING BY EATING CARRION (EXPLORATION PHASE)
            % CARRION selection using (3)
            k=randperm(SearchAgents,1);
            if k==i
                k=i+1;
                if k>SearchAgents
                    k=1;
                end
            end
            C_i=X(k,:); %status of CARRION
            F_Ci=fit(k); % objective function value of CARRION
            
            I=round(1+rand(1,1));
            % Calculating X_i_NEW,S1 using (4)
            if fit(i)>F_Ci
                X_new=X(i,:)+ rand(1,dimension).*(C_i-I.* X(i,:)); %Eq(11)
            else
                X_new=X(i,:)+ rand(1,dimension).*(X(i,:)-1.*C_i); %Eq(11)
            end
            X_new= max(X_new,lowerbound);X_new = min(X_new,upperbound);
            
            % Updating X_i using (5)
            f_new = fitness(X_new);
            if f_new <= fit (i)
                X(i,:) = X_new;
                fit (i)=f_new;
            end
            %% END STRATEGY 1: FEEDING BY EATING CARRION (EXPLORATION PHASE)
            
        else
            %% STRATEGY 2: FEEDING BY EATING PREY (EXPLOITATION PHASE)
            % stage1: prey selection and attack it
            % Prey selection using (6)
            k=randperm(SearchAgents,1);
            if k==i
                k=i+1;
                if k>SearchAgents
                    k=1;
                end
            end
            P_i=X(k,:);
            F_Pi=fit(k);
            
            I=round(1+rand(1,1));
            % Calculating X_i_NEW,S2 using (7)
            if fit(i)>F_Pi
                X_new=X(i,:)+ rand(1,dimension).*(P_i-I.* X(i,:)); %Eq(11)
            else
                X_new=X(i,:)+ rand(1,dimension).*(X(i,:)-1.*P_i); %Eq(11)
            end
            X_new= max(X_new,lowerbound);X_new = min(X_new,upperbound);
            
            % Updating X_i using (8)
            f_new = fitness(X_new);
            if f_new <= fit (i)
                X(i,:) = X_new;
                fit (i)=f_new;
            end
            % stage2: prey chasing
            R=0.01*(1-t/Max_iterations);% Calculating the neighborhood radius using(9)
            X_new= X(i,:)+ (-R+2*R*rand(1,dimension)).*X(i,:);% Calculating X_new using(10)
            X_new= max(X_new,lowerbound);X_new = min(X_new,upperbound);
            
            % Updating X_i using (11)
            f_new = fitness(X_new);
            if f_new <= fit (i)
                X(i,:) = X_new;
                fit (i)=f_new;
            end
            %% END STRATEGY 2: FEEDING BY EATING PREY (EXPLOITATION PHASE)
        end
        %%
    end
    
    %%
    
    best_so_far(t)=fbest;
    average(t) = mean (fit);
    
end
Best_score=fbest;
Best_pos=Xbest;
TDO_curve=best_so_far;
end

