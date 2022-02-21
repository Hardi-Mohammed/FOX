% %
%%FOX 
% FOX: A Fox-inspired Optimization Algorithm
% Authors: Hardi M. Mohammed, Tarik A. Rashid.
% FOX is implemented by Hardi M. Mohammed
%%
function [Best_score,Best_pos]=RFSO(SearchAgents_no,Max_iter,lb,ub,dim,fobj)

Best_pos=zeros(1,dim);
Best_score=inf; %change this to -inf for maximization problems
MinT=inf;

%Initialize the positions of search agents
X=initialization(SearchAgents_no,dim,ub,lb);
 Distance_Fox_Rat=zeros(SearchAgents_no,dim);

l=0;% Loop counter
% both c1 and c2 have different range value
c1=0.18;  % range of c1 is [0, 0.18]
c2=0.82;  % range of c2 is [0.19, 1]
% Main loop
while l<Max_iter
    for i=1:size(X,1)  
        
       % Return back the search agents that go beyond the boundaries of the search space
        Flag4ub=X(i,:)>ub;
        Flag4lb=X(i,:)<lb;
        X(i,:)=(X(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;               
   
        % Calculate objective function for each search agent
        fitness=fobj(X(i,:));
        
        % Update Alpha
        if fitness<Best_score 
            Best_score=fitness; % Update alpha
            Best_pos=X(i,:);
        end
    end
    a=2*(1-(l/Max_iter));
%       a=4-l*((4)/Max_iter);   
     Jump=0;
    
     %%add
     dir=rand;
     %%
    for i=1:size(X,1)
        r=rand;    
        p=rand;
                     if r>=0.5
                            if p>0.18
                                 Time(i,:)=rand(1,dim);
                         sps=Best_pos/Time(i,:);
                         Distance_S_Travel(i,:)=sps* Time(i,:);
                         Distance_Fox_Rat(i,:)=0.5* Distance_S_Travel(i,:);
                        tt=sum(Time(i,:))/dim;
                        t=tt/2;
                        Jump=0.5*9.81* t^2;
                       X(i,:)=Distance_Fox_Rat(i,:).*Jump * c1;
                            elseif p<=0.18
                                 Time(i,:)=rand(1,dim);
                                 sps=Best_pos/Time(i,:);
                        Distance_S_Travel(i,:)=sps* Time(i,:);
                         Distance_Fox_Rat(i,:)=0.5* Distance_S_Travel(i,:);

                        tt=sum(Time(i,:))/dim;
                        t=tt/2;
                         Jump=0.5*9.81* t^2;
                     X(i,:)=Distance_Fox_Rat(i,:).*Jump * c2;
                            end
                        if MinT>tt
                            MinT=tt;
                        end 
                        
                   elseif r<0.5
            %random walk
            ans(i,:)=Best_pos+randn(1,dim).*(MinT*a);% exploring new positions
                X(i,:)=ans(i,:);
  
                     end
    end
    l=l+1;    
end










