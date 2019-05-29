%%
%%%%%% predicton of label, link, and Block %%%%%%
%%%%%% input: Gamma_best,Theta_best        %%%%%%
%%%%%% output: PredLabel,PredA,BlockN      %%%%%%
function [PredLabel,BlockN] = CompPrediction(Gamma_best,Theta_best)
    %%% the number of blocks %%%
    Z = CompZ(Gamma_best);
    BlockN = size(Z,2);          % the number of blocks
    %%% the lable of nodes %%%
    PredLabel = zeros(length(Z),1);
    for i = 1:size(Z,2)
        for j = 1:length(Z)
            if Z(j,i) == 1 
                PredLabel(j) = i;% label of nodes
            end
        end
    end
end


