%% ControlFuzzy > MiniProject(1) > Part(1) > Problem(1)
x=0:.1:20;
y=0:.1:20;
sigma1=1;
sigma2=2;
c1=5;
c2=15;
A=MF('gauss',x,[c1 sigma1]);
B=MF('gauss',y,[c2 sigma2]);
[caA,caB] = meshgrid(A,B);
%% a)
plot(x,A,x,B)
%% b)
mesh(x,y,caA)
mesh(x,y,caB)
%% c)
minTnormAB = min(caA,caB);
algTnormAB = caA .* caB;
mesh(x,y,minTnormAB)
mesh(x,y,algTnormAB)
%% d)
projMinTnormX = projection(minTnormAB,'x');
projMinTnormY = projection(minTnormAB,'y');
projAlgTnormX = projection(algTnormAB,'x');
projAlgTnormY = projection(algTnormAB,'y');
subplot(231), mesh(x,y,projMinTnormX), title('min Tnorm Projection on X'), xlim([0 10]), xlabel('X'), ylabel('Y'), zlabel('MF')
subplot(234), mesh(x,y,projMinTnormY), title('min Tnorm Projection on Y'), xlim([0 10]), xlabel('X'), ylabel('Y'), zlabel('MF')
subplot(232), mesh(x,y,projAlgTnormX), title('algebraic Tnorm Projection on X'), xlim([0 10]), xlabel('X'), ylabel('Y'), zlabel('MF')  
subplot(235), mesh(x,y,projAlgTnormY), title('algebraic Tnorm Projection on Y'), xlim([0 10]), xlabel('X'), ylabel('Y'), zlabel('MF')
subplot(233), plot(x,projMinTnormX(1,:),'*',x,projAlgTnormX(1,:)), title('compare'), legend('min','alg'), xlim([0 10]), xlabel('X'), ylabel('MF')
subplot(236), plot(y,projMinTnormY(:,1),'*',y,projAlgTnormY(:,1)), title('compare'), legend('min','alg'), xlim([10 20]), xlabel('Y'), ylabel('MF')
%% e,f)
Xprim = 4.2; XprimMtx = zeros(numel(x)); XprimMtx(:,Xprim*10) = 1;
nextTnorm = XprimMtx .* algTnormAB;
nextProj = projection(nextTnorm,'y');

subplot(221), mesh(x,y,algTnormAB), hold on, mesh(x,y,XprimMtx), title('CE and intersection'), xlim([0,10]), xlabel('X'), ylabel('Y'), zlabel('MF')  
subplot(222), mesh(x,y,nextTnorm), title('t-norm'), xlim([0,10]), xlabel('X'), ylabel('Y'), zlabel('MF'), zlim([0,1])
subplot(224), mesh(x,y,nextProj), title('projection'), xlim([0,10]), xlabel('X'), ylabel('Y'), zlabel('MF'), zlim([0,1])
subplot(223), plot(y,nextProj(:,1),y,B), title("compare B and B'"), xlim([10,20]), xlabel('Y'), ylabel('MF'), legend("B'",'B')

