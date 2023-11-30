%% ControlFuzzy > MiniProject(1) > Part(1) > Problem(2)
x = -5:.1:20;
y = -10:.1:30;

sigma1 = 4;
sigma2 = 6;
%%
A1 = MF('gauss',6,sigma1).membership(x);
A2 = MF('gauss',10,sigma1).membership(x);
B1 = MF('gauss',6,sigma2).membership(y);
B2 = MF('gauss',12,sigma2).membership(y);

%% a)
[ceA1,ceB1] = meshgrid(A1,B1);
[ceA2,ceB2] = meshgrid(A2,B2);
R1 = ceA1.*ceB1;
R2 = ceA2.*ceB2;
%%
subplot(121), plot(x,A1,'r',x,A2,'b'), xlabel('x-axis'), ylabel('MF') %title('\sigma_1 = 4, \sigma_2 = 6')
subplot(122), plot(y,B1,'r',y,B2,'r'), xlabel('y-axis'), ylabel('MF')%title('\sigma_1 = 4, \sigma_2 = 6')
%%
mesh(x,y,ceA1,'EdgeColor','r'), hold on
mesh(x,y,ceA2,'EdgeColor','b')
mesh(x,y,ceB1,'EdgeColor','g')
mesh(x,y,ceB2,'EdgeColor','m')
% xlim([0,15]),
xlabel('x-axis'), ylabel('y-axis'), zlabel('MF'), legend('A1','A2','B1','B2')
%%
subplot(121), mesh(x,y,ceA1), hold on, mesh(x,y,ceB1), xlabel('x-axis'), ylabel('y-axis'), zlabel('MF')
subplot(122), mesh(x,y,ceA2), hold on, mesh(x,y,ceB2), xlabel('x-axis'), ylabel('y-axis'), zlabel('MF')
%%
subplot(121)
mesh(x,y,R1), hold on, mesh(x,y,R2)
xlabel('x-axis'), ylabel('y-axis'), zlabel('MF'), title('Relations')
%% b)
Xprim = 8; 

ceAp = zeros(size(x)); 
ceAp(:,Xprim*10) = 1;

% Ap = MF('gauss',x,[Xprim,2]);
% ceAp=meshgrid(Ap,y);
% mesh(x,y,ceAp,'FaceAlpha','0.2')
%%
tn1 = ceAp .* R1;
tn2 = ceAp .* R2;
maximum = max(tn1,tn2);
Bp1 = projection(tn1,'y');
Bp2 = projection(tn2,'y');
%%
% subplot(221), mesh(x,y,R1), hold on, mesh(x,y,R2), mesh(x,y,Ap)
%     zlim([0 1]), xlabel('x-axis'), ylabel('y-axis'), zlabel('MF')
% subplot(223), mesh(x,y,tn1), hold on, mesh(x,y,tn2)
%     zlim([0 1]), xlabel('x-axis'), ylabel('y-axis'), zlabel('MF')
% subplot(222), mesh(x,y,R1), hold on, mesh(x,y,R2), mesh(x,y,Ap)
%     zlim([0 1]), view([45 45]), xlabel('x-axis'), ylabel('y-axis'), zlabel('MF')
% subplot(224), mesh(x,y,tn1), hold on, mesh(x,y,tn2)
%     zlim([0 1]), view([45 45]), xlabel('x-axis'), ylabel('y-axis'), zlabel('MF')

subplot(121), mesh(x,y,tn1), hold on, mesh(x,y,tn2)
zlim([0 1]), xlabel('x-axis'), ylabel('y-axis'), zlabel('MF')

subplot(122), mesh(x,y,tn1), hold on, mesh(x,y,tn2), mesh(x,y,ceAp,'EdgeColor','r'), view([0 0])
zlim([0 1]), xlabel('x-axis'), ylabel('y-axis'), zlabel('MF')
%%
% subplot(321), mesh(x,y,R1), hold on, mesh(x,y,R2), mesh(x,y,ceAp)
%     zlim([0 1]), xlabel('x-axis'), ylabel('y-axis'), zlabel('MF')
% subplot(322), mesh(x,y,tn1), hold on, mesh(x,y,tn2)
    % zlim([0 1]), xlabel('x-axis'), ylabel('y-axis'), zlabel('MF')

% subplot(121), mesh(x,y,Bp1), hold on, mesh(x,y,Bp2)
%     zlim([0 1]), xlabel('x-axis'), ylabel('y-axis'), zlabel('MF')
% subplot(122), plot(y,Bp1(:,1),y,Bp2(:,1))
%     ylim([0 1]), xlabel('x-axis'), ylabel('y-axis'), zlabel('MF')

subplot(121), plot(y,max(Bp1(:,1),Bp2(:,1)))
    ylim([0 1]), xlabel('y-axis'), ylabel('Membership')
subplot(122), plot(y,max(Bp1(:,1),Bp2(:,1))), hold on, plot(y,max(B1,B2))
    ylim([0 1]), xlabel('y-axis'), ylabel('Membership')

%%
subplot(221), mesh(x,y,algTnormAB), hold on, mesh(x,y,XprimMtx), title('CE and intersection'), xlim([0,10]), xlabel('X'), ylabel('Y'), zlabel('MF')  
subplot(222), mesh(x,y,nextTnorm), title('t-norm'), xlim([0,10]), xlabel('X'), ylabel('Y'), zlabel('MF'), zlim([0,1])
subplot(224), mesh(x,y,nextProj), title('projection'), xlim([0,10]), xlabel('X'), ylabel('Y'), zlabel('MF'), zlim([0,1])
subplot(223), plot(y,nextProj(:,1),y,B), title("compare B and B'"), xlim([10,20]), xlabel('Y'), ylabel('MF'), legend("B'",'B')
%% test
plot(y,B1,y,B2), hold on, area(y,max(Bp1(:,1),Bp2(:,1))), title('results of 2.c')
xlabel('y-axis'), ylabel('Membership Value'), legend('B1','B2',"B'")
plot(y,Bp1(:,1),y,Bp2(:,1))
%%

