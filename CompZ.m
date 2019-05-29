%%
%%%%%% calculation of discrete Gamma %%%%%%
%%%%%% input: Gamma                  %%%%%%
%%%%%% output: discete Gamma: Z      %%%%%%
function Z = CompZ(Gamma)
Z = Gamma;
[L,K] = size(Gamma);
for i = 1:L
    [m,l] = max(Z(i,:));
    Z(i,:) = zeros(1,K);
    Z(i,l) = 1;   
end


