%%
%%%%%% initialization of main parameters         %%%%%%
%%%%%% input: A                                  %%%%%%
%%%%%% output: Gamma,Theta,Omega,GammaU,Exponent %%%%%%
function [Gamma,Theta,Omega,GammaU,Exponent] = Initialization01( tA, t  )
global N K_max 
%%% initializing Gamma, Theta, Omega %%%
 rand('seed',t+1)
Theta = rand(K_max,N);
Omega = ones(K_max,1)/K_max;
Gamma = rand(N,K_max);
%%% normalization of Gamma %%%
for i = 1:N
    Gamma(i,:) = Gamma(i,:)/sum(Gamma(i,:));
end
%%% computation of Theta and Omega %%%
for m=1:K_max
  [Theta(m,:)] = CompTheta(tA,Gamma(:,m)); % computing Theta
  Omega(m) = sum(Gamma(:,m),1)/N;      % normalizing Omega
end  
%%% initialization of likelihood and posteriori %%%
GammaU = zeros(N,K_max);   %**% precomputation for saving time
Exponent = zeros(N,K_max); %**% precomputation for saving time
for m = 1:K_max
  [GammaU(:,m),Exponent(:,m)] = CompGammaU(tA,Theta(m,:)); % 
end
for m = 1:K_max
    Gamma(:,m) = CompGamma( m,GammaU, Exponent, Omega );
end
end


