
global K_max N K_min LengthofA
tA = load('N=400_K=4_fulledge.dat');
N = max(max(tA));

Label = load('N=400_K=4_Label.dat');
LengthofA = size(tA,1);
%%% performing EM %%%
K_min = 2; % the min number of discovered blocks
K_max = 20; % the max number of discovered blocks


CostSet    = []; % including all cost values
OptCostSet = []; % including optimized cost values
OptCost = 10^10; % initialization of OptCost
Rand    = 5;    % times of random initializatin 

for time = 1:Rand
    [Gamma,Theta,Omega,Cost]=CompEM( tA, time ); % E
    CostSet=[CostSet,Cost]; % for plotting
    if Cost < OptCost % updating optimal results
        OptCost = Cost;
        OptCostSet = [OptCostSet, OptCost]; % for plotting
        OptGamma = Gamma; 
        OptTheta = Theta; 
        OptOmega = Omega;
    end
end

%%% computation of accuracy %%%
[PredLabel,BlockN] = CompPrediction(OptGamma,OptTheta); % predictions of Label, blocks, and A
NMI = CompNMI(PredLabel,Label);






