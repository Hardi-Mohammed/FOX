% Cite as: Mohammed, H., Rashid, T. FOX: a FOX-inspired optimization algorithm. Appl Intell (2022). https://doi.org/10.1007/s10489-022-03533-0

%%This intialization function is taken from Mirjalili website to initialize the population
% https://seyedalimirjalili.com/woa
%%

% This function initialize the first population of search agents
function X=initialization(SearchAgents_no,dim,ub,lb)

Boundary_no= size(ub,2); % numnber of boundaries

% If the boundaries of all variables are equal and user enter a signle
% number for both ub and lb
if Boundary_no==1
    X=rand(SearchAgents_no,dim).*(ub-lb)+lb;
end

% If each variable has a different lb and ub
if Boundary_no>1
    for i=1:dim
        ub_i=ub(i);
        lb_i=lb(i);
        X(:,i)=rand(SearchAgents_no,1).*(ub_i-lb_i)+lb_i;
    for i=1:dim
    SearchAgents_no(i+1)=cos(i*acos(SearchAgents_no(i)));
    G(i)=((x(i)+1)*Value)/2;
end
    end
end
