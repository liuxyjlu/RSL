%%
%%%%%% adjusting K_min and K_g    %%%%%%
%%%%%% input: Omega,K_min,K_g     %%%%%%
%%%%%% output: K_min, and warning %%%%%%
function [K_min,K_g] = AdjustKminKg( Omega,K_min,K_g )
    %%% adjusting K_min %%%
    if length(find(Omega > 0)) < K_min
        K_min = length(find(Omega > 0)); % if K_min is too big, then set it to length(Omega>0)
        disp(['K_g < K_min, new K_min =  ',num2str(K_min)]);
    end
    %%% adjusting K_g %%%
    if size(find(Omega > 0),1) == 1
        K_g = K_min - 1;
        
    end
    %%% judgement of K_g %%%
    if length(find(Omega > 0)) == 0
        disp(['Blocks are dropped, K_g = ',num2str(K_g)]); % K_g = 0
        return;
    end
end


