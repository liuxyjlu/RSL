%%
%%%%%% computation of Gamma                 %%%%%%
%%%%%% input: m, m,GammaU, Exponent, Omega  %%%%%%
%%%%%% output: posteriori estimate of Gamma %%%%%%
function Gamma_m = CompGamma( m,GammaU, Exponent, Omega )
   global N
   Gamma_m = zeros(N,1);
   for i = 1:N
       SumOU = 0; % summation of Omega*GammaU
       i_min = find(Exponent(i,:) == min(Exponent(i,:)));
       i_min1=find(Exponent(i,:) == min(Exponent(i,:))+1);

       for j=i_min1
           GammaU(i,j) = GammaU(i,j)*10^-40;
           SumOU = SumOU + Omega(j)*GammaU(i,j);
       end

       for j = i_min %j=1:K  ???             
           SumOU = SumOU + Omega(j)*GammaU(i,j);
       end
       if Exponent(i,m) == min(Exponent(i,:)) || Exponent(i,m) == min(Exponent(i,:))+1
           Gamma_m(i,1) = Omega(m)*GammaU(i,m)/SumOU;
       else
           Gamma_m(i,1) = 0;  
       end
   end
end



