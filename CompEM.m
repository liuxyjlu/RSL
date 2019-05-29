%%
%%%%%% the EM process of BLOS                %%%%%%
%%%%%% input: A, Rand                        %%%%%%
%%%%%% output: optimized parameters and cost %%%%%%
function [OptGamma,OptTheta,OptOmega,Cost1] = CompEM( tA,Rand )
global K_min K_max N
%%% initialization of all parameters %%%
[Gamma,Theta,Omega,GammaU,Exponent] = Initialization01(tA,Rand);
[Diff_min,Cost0,IterEM,K_g] = Initialization02();
Cost=Cost0;
Opt=struct('Gamma',Gamma,'Theta',Theta,'Omega',Omega,'Cost',Cost);
%%% performing EM algorithm %%%
disp(['Computing EM algorithm: ',num2str(Rand)]); % 
stop = true;
ii=0;
while stop
   
    for m = 1:K_max
      % ii=ii+1;
        %%% adjusting K_min and K_g before EM %%%
        %[K_min,K_g] = AdjustKminKg( Omega,K_min,K_g );
        %%% beginning of EM %%%
        if Omega(m) > 0
              ii=ii+1;
            %%% computation of Gamma %%%
            Gamma(:,m) = CompGamma( m,GammaU, Exponent, Omega );
            %%% computation of Omega %%%
            Omega = CompOmega(Gamma,Omega, K_g, m);
            %%% computation of Theta and GammaU %%%
            if Omega(m) > 0
                [Theta(m,:)] = CompTheta(tA,Gamma(:,m));
                %%% precomputation of GammaU %%%
                [GammaU(:,m),Exponent(:,m)] = CompGammaU(tA,Theta(m,:));
            else
                %%% model selection process %%%
                K_g = K_g - 1; % 
                if K_g < K_min
                    break;
                end
                %%% removing the block %%%
                Gamma(:,m) = 0; %
                Theta(m,:) = 0;
                GammaU(:,m) = 0;
                Exponent(:,m) = 10^10;
                
            end
             K_g1(ii)=K_g;
              Cost11(ii) = CompCost( Omega, Exponent,K_g, GammaU );
        end
       % ii
        
    end
  
    for i = 1:N
        Gamma(i,:) = Gamma(i,:) / sum(Gamma(i,:));
    end
    IterEM = IterEM + 1; % time of iterations in EM
    %%% calculation of cost function %%%
    Cost1 = CompCost( Omega, Exponent,K_g, GammaU );
    if K_g<K_min
        Cost1 = 10^20;
    end
    if Cost1 < Opt.Cost
        Opt.Omega = Omega;
        Opt.Theta = Theta;
        Opt.Gamma = Gamma;
        Opt.Cost = Cost1;
    end
 
    if Cost0 - Cost1 < Diff_min || K_g<K_min% judgement of convergence
        stop = false; 
    end 
    Cost0 = Cost1;
    %%% displaying the main features %%%
    if K_g==1
        K_g
    end
    %disp(['Iter = ',num2str(IterEM),' K_g = ',num2str(K_g),' Cost = ', num2str(Cost1)]);
end
%%% updating parameters %%%
% OptIndex = find(Omega>0);
% OptGamma = Gamma(:,OptIndex); 
% OptTheta = Theta(OptIndex,:);
% OptOmega = Omega(OptIndex);
Cost1 = Opt.Cost;
OptIndex = find(Opt.Omega>0);
OptGamma = Opt.Gamma(:,OptIndex); 
OptTheta = Opt.Theta(OptIndex,:);
OptOmega = Opt.Omega(OptIndex);
end


