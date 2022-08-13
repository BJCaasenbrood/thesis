clr;
%%
A = load('mckibben.txt');
B = load('ormbend.txt');
C = load('ormexent.txt');

C(:,2) = C(:,2) - C(1,2);

Xq = linspace(0,1,200);
X  = linspace(0,1,20);

Y1 = interp1(A(:,1)/max(A(:,1)),A(:,2)/max(A(:,2)),Xq,'spline');
Y2 = interp1(B(:,1)/max(B(:,1)),B(:,2)/max(B(:,2)),X,'spline');
Y3 = interp1(C(:,1)/max(C(:,1)),C(:,2)/max(C(:,2)),X,'spline');


f = fig(101,[9.75,8.35]); sorocolor;

[~,I] = mink(abs(gradient(Y1)),5); 
I = I(2);
plot(Xq(1:I),Y1(1:I),'Color',col(1),'LineW',1.5); hold on;
plot(Xq(I:end),Y1(I:end),'--','Color',col(1),'LineW',1.5);

plot(X,Y2,'LineW',1.5,'Color',col(2));
plot(X,Y3,'LineW',1.5,'Color',col(4));
plot(X,X,'--','LineW',1.5,'Color',col(10));

sorocolor;
box on;
grid on;
set(gca,'LineW',1.5);
xlabel('volume ratio $\delta V/\delta V_{max}$','interpreter','latex');
ylabel('actuation ratio $\delta U/\delta U_{max}$','interpreter','latex');
axis([0,1,-0.1,1.4]);

legend({'McKibben','','Orm bending','Orm elongation','linearity'},'Orientation',...
    'Vertical','Location','NW','Interpreter','latex');

%%
thesispath = @(x) ['~/Documents/phd/thesis/3_chapters/',x];

W0 = 0.85;
X = num2str(W0,4);
Y = num2str((f.InnerPosition(4)/f.InnerPosition(3))*W0,4);

cleanfigure('targetResolution', 100);
matlab2tikz(thesispath('0_introduction/img/fig_mckibbenvsorm.tex'),...
     'width',[X,'\textwidth'],'height',[Y,'\textwidth']);