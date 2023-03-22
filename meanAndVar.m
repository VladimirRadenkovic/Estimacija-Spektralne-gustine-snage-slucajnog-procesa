function [m,Var] = meanAndVar(X)
m = zeros(1,512);
for i = 1:512
    for j = 1:50
        m(i) = m(i) + X(j,i);
    end
    m(i) = m(i)/50;
end;
Var = zeros(1,512);
for i = 1:512
    for j = 1:50
        Var(i) = Var(i) + (X(j,i) - m(i))^2;
    end
    Var(i) = Var(i)/49;
end;
end

