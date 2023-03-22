function Pper = per(X,f)
Pper = zeros(50,512);
N = length(X(1,:));
for i = 1:50
    for k = 1:512
        for n = 0:N-1
            Pper(i,k) = Pper(i,k) + X(i,n+1)*exp(-j*2*pi*f(k)*n);
        end
        Pper(i,k)=abs(Pper(i,k))^2/N;
    end
end
end

