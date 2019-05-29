%%
%%%%%% computation of Omega       %%%%%%
%%%%%% input: Gamma,Omega, K_g, m %%%%%%
%%%%%% output: updated Omega      %%%%%%
function Omega = CompOmega(Gamma,Omega, K_g, m)
global K_max 
    Omega(m) = max([0,sum(Gamma(:,m)) - K_g]); %
    SumOU = 0; % normalization
    if Omega(m)~=0
        for j = 1:K_max
            SumOU = SumOU + max([0,(sum(Gamma(:,j)) - K_g)]); %
        end
        Omega(m) = Omega(m)/SumOU; % 
    end
    Omega = Omega/sum(Omega);
end


