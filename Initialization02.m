%%
%%%%%% initialization of other parameters %%%%%%
%%%%%% input: --                          %%%%%%
%%%%%% output: Diff_min,Cost0,IterEM,K_g  %%%%%%
function [Diff_min,Cost0,IterEM,K_g] = Initialization02()
global K_max
Diff_min = 10^-4;% controling the covergnece
Cost0 = 10^50;   % cost function
IterEM = 0;      % times of iteration in EM
K_g = K_max;     % current number of blocks
end


