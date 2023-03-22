close all;
clear all;
clc;
M = 50;
N = 256;
T = readtable('x0.csv');
X = T{:,:};
f = linspace(-1/2+1/512,1/2,512);
%% 1.
Pper = per(X,f);
Pbt = blackmanTukey(X,40);
%% 2.
for i = 1:5
    figure(1)
    hold all;
    plot(f,Pper(9*i,:))
end
xlabel('f');
ylabel('Pper(f)');
title('Periodogrami za 5 izabranih realizacija');
legend('9. realizacija','18. realizacija','27. realizacija','36. realizacija','45. realizacija');
%% 3.
figure(2)
hold all;
M = 10;
Pbt = blackmanTukey(X,M);
plot(f,Pbt(1,:));
M = 40;
Pbt = blackmanTukey(X,M);
plot(f,Pbt(1,:));
M = 128;
Pbt = blackmanTukey(X,M);
plot(f,Pbt(1,:));
title('Blackman-Tukey metoda, optimalno M = 40');
legend('M = 10','M = 40', 'M = 128');
xlabel('f');
ylabel('Pbt(f)');
%% 4.
x = X(1,:);
% 50% peklapanje
figure(3)
subplot(3,3,1)
plot(f,pwelch(x,16,[],512,1,'centered').');
title ('Welch-ova metoda M = 16, preklapanje 50%')
xlabel('f');
ylabel('Pw(f)');
subplot(3,3,2)
plot(f,pwelch(x,32,[],512,1,'centered').');
title ('Welch-ova metoda M = 32, preklapanje 50%')
xlabel('f');
ylabel('Pw(f)');
subplot(3,3,3)
plot(f,pwelch(x,96,[],512,1,'centered').');
title ('Welch-ova metoda M = 96, preklapanje 50%')
xlabel('f');
ylabel('Pw(f)');
subplot(3,3,4)
plot(f,pwelch(x,128,[],512,1,'centered').');
title ('Welch-ova metoda M = 128, preklapanje 50%')
xlabel('f');
ylabel('Pw(f)');
subplot(3,3,5)
plot(f,pwelch(x,64,[],512,1,'centered').');
title ('Welch-ova metoda M = 64, preklapanje 50%')
xlabel('f');
ylabel('Pw(f)');
% 75% preklapanje
subplot(3,3,6)
plot(f,pwelch(x,16,16*0.75,512,1,'centered').');
title ('Welch-ova metoda M = 16, preklapanje 75%')
xlabel('f');
ylabel('Pw(f)');
subplot(3,3,7)
plot(f,pwelch(x,32,32*0.75,512,1,'centered').');
title ('Welch-ova metoda M = 32, preklapanje 75%')
xlabel('f');
ylabel('Pw(f)');
subplot(3,3,8)
plot(f,pwelch(x,64,64*0.75,512,1,'centered').');
title ('Welch-ova metoda M = 64, preklapanje 75%')
xlabel('f');
ylabel('Pw(f)');
subplot(3,3,9)
plot(f,pwelch(x,128,128*0.75,512,1,'centered').');
title ('Welch-ova metoda M = 128, preklapanje 75%')
xlabel('f');
ylabel('Pw(f)');

%% 5.
Pw = welch(X);
Pbt = blackmanTukey(X,40);
[mPer,VarPer] = meanAndVar(Pper);
[mW,VarW] = meanAndVar(Pw);
[mBt,VarBt] = meanAndVar(Pbt);
figure(4) 
plot(f,VarPer)
hold on
plot(f,VarW)
plot(f,VarBt)
legend('VarPer','VarW','VarBt');
title('Varijanse estimatora');
xlabel('f');
medPer = median(VarPer)
medPer = median(VarW)
medPer = median(VarBt)
%% 6.
VarPapprox = zeros(1,512);
for i = 1:512
    VarPapprox(i) = mPer(i)^2*(1+(sin(2*pi*256*f(i))/(256*sin(2*pi*f(i))))^2);
end
VarPapprox(256) = 2*mPer(256)^2;
VarPapprox(1) = 2*mPer(1)^2;
VarPapprox(512) = 2*mPer(512)^2;
figure(5)
plot(f,VarPer);
hold all;
plot(f,VarPapprox);
legend('Var dobijena usrednjavanjem','Var dobijena anal. izrazom');
title ('Varijanse periodograma');
xlabel('f');
%% 7.
int = confidenceInterval(Pbt(1,:),40);
PbtL = zeros(1,512);
mPerL = zeros(1,512);
for i = 1:512
    PbtL(1,i) = 10*log10(Pbt(1,i));
    int(1,i) = 10*log10(int(1,i));
    int(2,i) = 10*log10(int(2,i));
    mPerL(i) = 10*log10(mPer(i));
end
figure(6)
plot(f,PbtL);
hold all;
plot(f,int(1,:),'--');
plot(f,int(2,:),'--');
plot(f,mPerL);
legend('Blackman-Tukey estimacija','Donja granica intervala poverenja','Gornja granica intervala poverenja','Usrednjeni periodogram')
title('Blackman-Tukey estimacija i interval poverenja');
xlabel('f');
%% 8.
X1 = X(:,1:64);
Pper1 = per(X1,f);
[mPer1, VarPer1] = meanAndVar(Pper1);
for i = 1:50
    figure(7)
    hold all;
    plot(f,Pper1(i,:))
end
figure(8)
plot(f,VarPer);
hold all;
plot(f,VarPer1);
legend('N = 256','N = 64');
title('Varijanse skracenog i originalnog periodograma');
xlabel('f');
medianVper = median(VarPer)
medianVper1 = median(VarPer1)
%%
% n = 0:63;
% Pper1 = per(X(:,1:64),f);
% Pper2= per(X(:,65:128),f);
% Pper3 = per(X(:,129:192),f);
% Pper4= per(X(:,193:256),f);
% [mPer1, VarPer1] = meanAndVar(Pper1);
% [mPer2, VarPer2] = meanAndVar(Pper2);
% [mPer3, VarPer3] = meanAndVar(Pper3);
% [mPer4, VarPer4] = meanAndVar(Pper4);
% figure(10)
% hold all;
% plot(f,VarPer);
% plot(f,VarPer1);
% % plot(f,VarPer2);
% % plot(f,VarPer3);
% % plot(f,VarPer4);
% % legend('v','v1','v2','v3','v4');
% %% Pper1 = per(X(:,1:64),f);
% vp = zeros(1,512);
% vbt = zeros(1,512);
% vw = zeros(1,512);
% for i = 1:512
%     vp(i) = var(Pper(:,i));
%     vbt(i) = var(Pbt(:,i));
%     vw(i) = var(Pw(:,i));
% end
% figure(11)
% plot(f,vp);
% hold all
% plot(f,vbt);
% plot(f,vw);
% legend('vp','vbt','vw');

int = confidenceInterval(Pbt(1,:),40);
y = 10*log10(int(2,:)./int(1,:));
figure(14)
plot(f,y)