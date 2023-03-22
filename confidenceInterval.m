function int = confidenceInterval(Pbt,M)
a = 0.05;
w = bartlett(2*M+1)';
v = 2*256/sum(w.^2);
int = zeros(2,512);
for i = 1:512
    int(1,i) = v*Pbt(i)/chi2inv((1-a/2),v);
    int(2,i) = v*Pbt(i)/chi2inv((a/2),v);
end

end

