%%
%%%%%% Calculation of Cost function       %%%%%%
%%%%%% input: Omega, Ugamm_int,K_g, Ugamm %%%%%%
%%%%%% output: the value of cost          %%%%%%
function Cost = CompCost( Omega, Ugamm_int,K_g, Ugamm )
global N K_max
    %%% Eq.: log p(N | K_g,Theta, Omega) %%%
    term1 = 0; % the first term
   % min_U = min(min(Ugamm_int));
    for i = 1:N  %
        [sort_U, indexu]= sort(Ugamm_int(i,:));
        min_int=min(Ugamm_int(i,:));
        msort=find(sort_U==min_int);
        Temp = 0; % for summation
        for t=1:length(msort)              
                min_U =sort_U(t);
                ii=indexu(t);
            if Omega(ii) > 0  
                if Ugamm_int(i,ii) == min_U 
                    Temp = Temp + Omega(ii)*Ugamm(i,ii); 
                else
                    Ugamm_int(i,ii)                   
                end 
            end            
        end
            while Temp==0 && t~=K_max
                t=t+1;
                min_U =sort_U(t);
                ii=indexu(t);
      
            if Omega(ii) > 0  
                if Ugamm_int(i,ii) == min_U 
                    Temp = Temp + Omega(ii)*Ugamm(i,ii); 
                else
                    Ugamm_int(i,ii)                   
                end 
            end  
                
            end     

      if 1/Temp > 10^300
          Temp=10^-300;
      
      end

      term1 = term1 + min_U*log2(10^-40) + log2(Temp);
    end
    %%% priori information %%%
    term2 = 0; % the second term
    for k = 1:K_max
        if Omega(k) > 0
            term2 = term2 + K_g*log2(Omega(k)); 
        end 
    end
    term3 = 0.5*(2*K_g^2 + K_g)*(1 + log2(1/12) + log2(N)); % the third term
    %%% the cost function %%%
    Cost =  - term1 + term2 + term3; 
end


