function Pw = welch(X)
Pw = zeros(50,512);
for i = 1:50
    Pw(i,:) = pwelch(X(i,:),64,[],512,1,'centered').';
end
end

