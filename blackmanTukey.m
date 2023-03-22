function Pbt = blackmanTukey(X,M)
w = [zeros(1,255-M) bartlett(2*M+1)' zeros(1,255-M)];
f = linspace(-1/2+1/512,1/2,512);
Pbt = zeros(50,512);
for i = 1:50
    rxx = autokorelacija(X(i,:));
    x = rxx.*w;
    for k = 1:512
        for n = -255:-1
            Pbt(i,k) = Pbt(i,k) + x(n+256)*exp(-j*2*pi*f(k)*n);
        end
        for n = 0:255
            Pbt(i,k) = Pbt(i,k) + x(n+256)*exp(-j*2*pi*f(k)*n);
        end
    end
end
end

