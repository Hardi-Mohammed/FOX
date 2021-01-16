% %
%% RFSOA 
% Red Fox in the Snow Optimization Algorithm for Solving Pressure Vessel
% Desing Problem.
% Authors: Hardi M. Mohammed, Tarik A. Rashid.
% RFSOA is implemented by Hardi M. Mohammed
%%
function [Alpha_score,Alpha_pos]=RFSOA(SearchAgents_no,Max_iter,lb,ub,dim,fobj)

Alpha_pos=zeros(1,dim);
Alpha_score=inf; %change this to -inf for maximization problems
MinT=inf;

%Initialize the positions of search agents
Positions=initialization(SearchAgents_no,dim,ub,lb);
 Distance_Fox_Rat=zeros(SearchAgents_no,dim);
Convergence_curve=zeros(1,Max_iter);

l=0;% Loop counter
% Main loop
while l<Max_iter
    for i=1:size(Positions,1)  
        
       % Return back the search agents that go beyond the boundaries of the search space
        Flag4ub=Positions(i,:)>ub;
        Flag4lb=Positions(i,:)<lb;
        Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;               
   
        % Calculate objective function for each search agent
        fitness=fobj(Positions(i,:));
        
        % Update Alpha
        if fitness<Alpha_score 
            Alpha_score=fitness; % Update alpha
            bestP=Positions(i,:);
        end
    end
    a=2*(1-(l/Max_iter));
%       a=4-l*((4)/Max_iter);   
     Jump=0;
    
    for i=1:size(Positions,1)
        r=rand;    
        p=rand;
                     if r>=0.5
                            if p>0.18
                                 Time(i,:)=rand(1,dim);
                         sps=bestP/Time(i,:);
                         Distance_S_Travel(i,:)=sps* Time(i,:);
                         Distance_Fox_Rat(i,:)=0.5* Distance_S_Travel(i,:);
                        tt=sum(Time(i,:))/dim;
                        t=tt/2;
                        Jump=0.5*9.81* t^2;
%                         Jump= bestP-Positions(i,:);
                        Positions(i,:)=Distance_Fox_Rat(i,:).*Jump * 0.18;
                            elseif p<=0.18
                                 Time(i,:)=rand(1,dim);
                                 sps=bestP/Time(i,:);
                        Distance_S_Travel(i,:)=sps* Time(i,:);
                         Distance_Fox_Rat(i,:)=0.5* Distance_S_Travel(i,:);

                        tt=sum(Time(i,:))/dim;
                        t=tt/2;
                         Jump=0.5*9.81* t^2;
%  Jump= bestP-Positions(i,:);
                       Positions(i,:)=Distance_Fox_Rat(i,:).*Jump * 0.82;
                            end
                        if MinT>tt
                            MinT=tt;
                        end 
                        
                   elseif r<0.5
            %random walk
            ans(i,:)=bestP+randn(1,dim).*(MinT*a);% exploring new positions
                Positions(i,:)=ans(i,:);
  
                     end
    end
    l=l+1;    
end





