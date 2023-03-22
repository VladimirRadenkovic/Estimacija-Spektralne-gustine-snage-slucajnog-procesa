function rxx = autokorelacija(x)
 N = length(x);
 for k = 0:(N-1)
     rxx(k+1) = 0;
     for i = 0:(N-1-k)
         rxx(k+1) = rxx(k+1) + x(i+1)*x(i+k+1);
     end
     rxx(k+1) = rxx(k+1)/N;
 end
 rxx = [rxx(end:-1:2) rxx];
end
