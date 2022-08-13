clr;

A = (load('softrobot.txt'));
B = (load('flexiblerobot.txt'));
C = (load('softmachine.txt'));
D = (load('softactuator.txt'));

[YearA,PubA,FA] = extractData(A);
[YearB,PubB,FB] = extractData(B);
[YearC,PubC,FC] = extractData(C);
[YearD,PubD,FD] = extractData(D);

Y = @(x) exp(1.01*x-1999).^(0.2223) + 10;

f = fig(101,[9.75,8.25]); sorocolor;

x = round(linspace(1995,2025,1e3)).';
X = datetime([x,x*0+1,x*0+1]);

semilogy(YearA,FA,'.','LineW',2,'MarkerSize',10); hold on;
semilogy(YearB,FB,'s','LineW',2,'MarkerSize',3); hold on;
semilogy(YearD,FD,'d','LineW',2,'MarkerSize',2); hold on;
semilogy(X,Y(x),'k--','LineW',1.5,'Color',col(6));
%plot(YearC,FC/1e3,'.-','Color',col(4),'LineW',2,'MarkerSize',25); hold on;
%plot(Year,F/F(end)*3e3,'.-','LineW',2,'MarkerSize',25); hold on;
ylabel('#publications (cumulative)')
%axis([1980 2022 -1e3 20e3]);
xlim([datetime(1980,1,1) datetime(2025,1,1)])
ylim([-1e3 25e3]);
% ax = gca();
% ax.YRuler.Exponent = 3;
% ax.YRuler.TickLabelFormat = '%i';

legend({'Soft robot(s)','Flexible/redundant robot(s)',...
    'Soft actuator(s)','Prediction'},...
    'Location','NW')
box on;
set(gca,'LineW',1.5);
grid on;
%plot(Year(2:end),FF,'.-','LineW',2,'MarkerSize',25);

%
thesispath = @(x) ['~/Documents/phd/thesis/3_chapters/',x];

W0 = 0.9;
X = num2str(W0,4);
Y = num2str((f.InnerPosition(4)/f.InnerPosition(3))*W0,4);

%cleanfigure('targetResolution', 100);
matlab2tikz(thesispath('0_introduction/img/fig_1_3.tex'),...
     'width',[X,'\textwidth'],'height',[Y,'\textwidth']);

function [Year,Pub,F] = extractData(A) 

[X,I] = sort(A(:,1));
Year = datetime([X,X*0+1,X*0+1]);
Pub  = A(I,2);

F = cumsum(Pub);
FF = diff(Pub);

end