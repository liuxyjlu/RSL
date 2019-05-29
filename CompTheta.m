%%
%%%%%% computation of Theta %%%%%%
%%%%%% input: A,Gamma_m     %%%%%%
%%%%%% output: Theta_m      %%%%%%
function [Theta_m] = CompTheta(tA,Gamma_m)   
global N LengthofA
Theta_m = zeros(1,N);
if sum(Gamma_m) ~= 0
    for indtA = 1 : LengthofA
        i = tA(indtA,1);
        j = tA(indtA,2);
       Theta_m(j) = Theta_m(j) + Gamma_m(i);
    end
    Theta_m = Theta_m/sum(Gamma_m);
end
end


