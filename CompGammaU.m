%%
%%%%%% precomputation of GammaU %%%%%%
%%%%%% input: A,Theta           %%%%%%
%%%%%% output: GammaU,Exponent  %%%%%%
function [GammaU,Exponent] = CompGammaU(tA,Theta_m)
global N LengthofA
%GammaU   = ones(N,1)*exp(-sum(Theta_m)); % the likelihood of the network
%GammaU   = zeros(N,1); 
Exponent = zeros(N,1); % counter of the exponent of GammaU
alpha_m = 1;
for i=1:N
alpha_m = alpha_m*exp(-Theta_m(i));
if alpha_m < 10^-50
    alpha_m = alpha_m*10^40;
    Exponent =Exponent + 1;
end
end
GammaU   = ones(N,1)*alpha_m;

for indtA = 1 : LengthofA
    i = tA(indtA,1);
    j = tA(indtA,2);
    GammaU(i) =  GammaU(i)*Theta_m(j);
    if GammaU(i)<0
          GammaU(i) = 0;
    end
    if  GammaU(i) < 10^-50
        GammaU(i) = GammaU(i)*10^40;
        Exponent(i) = Exponent(i) + 1; % accumulating the exponent
    end

end
end


