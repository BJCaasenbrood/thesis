clr;
%%
f = fig(101,[10.5,8.0]); axis off;

ha = tight_subplot(2,1,[.01 .03],[.1 .01],[.01 .01]);
axes(ha(1)); axis off;

axes(ha(2));

E0 = 4;
E1 = 12;
x = logspace(E0,E1,(E1-E0)*10);
% 
semilogx(x,x*0,'-','Color','w');
XTick = [];
lab = {};
for ii = E0:1:E1
    lab{numel(lab)+1} = ['10^{',num2str(ii),'}'];
%     XTick = [XTick,10^ii];
%     for jj = 1:9
%        lab{numel(lab)+1} = '';
%        XTick = [XTick,10^(ii + jj*0.1)];
%     end
end

set(gca,'XTickLabel',lab)
%set(gca,'XTick',XTick)
set(gca,'YTick',[])
ylim([-1,1]);
xlim([1e4,1.1e12]);
set(gca,'LineW',1.0)
box on;
grid on;

set(ha(2),'xscale','log');
hold on;

%%
% X = {4.1,'Hydrogel',5,7;
%      4.8,'Elastomers',25,7;
%      4.5,'Fat',5,4;
%      %db(10e3),'Skeletal muscle',5,4;
%      db(500e3),'Cartilage',7,4;
%      6.3,'Artery',4,4;
%      7.5,'Rubber',10,7;
%      8.3,'Muscle',12,4;
%      8.9,'Tendon',7,4;
%      db(68e9),'Aluminium',3,7;
%      db(14e9),'Bone',7,4;
%      db(200e9),'Steel',7,7;
%      db(2.9e9),'Nylon',3,7;
%      db(1e7),'Skin',3,4;
%      db(9e9),'Wood',7,7;
%      db(40e9),'Glass',7,7;
%      db(92e9),'Tooth enamel',7,4;
%      db(1050e9),'Diamond',3,7};

% %%
% for ii = 1:size(X,1)
%     plotMat(X{ii,1},X{ii,2},X{ii,3},X{ii,4},ha(2));
%     drawnow;
% end
% 
% %%

Ceng = col(7);
Cbio = col(8);
C3d = col(6);

X = {[10, 15]*1e3,'Hydrogel',Ceng;
     [0.1, 0.77]*1e6,'Elastomer',Ceng;
     [24-3.5, 24.+3.5]*1e3,'Skeletal muscle',Cbio;
     [90, 110]*1e3,'Cardiac muscle',Cbio;
     10.^[6.1, 6.3],'Artery',Cbio;
     10.^[7.5, 7.8],'Rubber',Ceng;
     [14e9,16e9],'Bone',Cbio;
     [60e9,66e9],'Aluminium',Ceng;
     [3.2e9,4e9],'Nylon',Ceng;
     [8e8,3e9],'Epoxy',Ceng;
     [1e7,1.2e7],'Skin',Cbio;
     [8e9,9.3e9],'Wood',Cbio;
     [89e9,99e9],'Tooth enamel',Cbio;
     [1020e9,1100e9],'Diamond',Ceng;
     %[3.5e9,3.8e9],'PLA',Ceng;
     [190e9,200e9],'Steel',Ceng};

%xlabel('\scriptsize Youngs Modulus (Pa)'); 
 
for ii = 1:size(X,1)
    plotMatV(X{ii,1},X{ii,2},X{ii,3},ha(2));
    drawnow;
end

annotation('arrow',[0.50,0.15],[0.2,0.2],'Color','k');
annotation('arrow',[0.55,0.90],[0.2,0.2],'Color','k');

text(3e7,0.1,'\scriptsize soft');
text(3e8,0.1,'\scriptsize rigid');

% 
% legend({'','Engineering','','Organic'},'Location','northoutside',...
%     'EdgeColor','none','Orientation','horizontal');

%plotMatV([1.5e9,11.9e9],'Wood',4,ha(2))


%%
% 
pause(0.1);
thesispath = @(x) ['~/Documents/phd/thesis/3_chapters/',x];

W0 = 0.95;
X = num2str(W0,4);
Y = num2str((f.InnerPosition(4)/f.InnerPosition(3))*W0,4);

%cleanfigure('targetResolution', 100);
matlab2tikz(thesispath('0_introduction/img/fig_stiffness_spectrum.tex'),...
     'width',[X,'\textwidth'],'height',[Y,'\textwidth']);

%%

% function plotMat(X,name,W,C,HA)
% plot([10^X,10^X],[-1+1e-3,1-1e-3],'-'...
%     ,'LineW',round(W),'Color',col(round(C)));
% 
% xlim=get(HA,'XLim');
% ylim=get(HA,'YLim');
% ht = text(10^X-0.15*(10^X),0.6*ylim(1)+0.4*ylim(2)+1.5,['\scriptsize ',name]);
% set(ht,'Rotation',70)
% end

function plotMatV(X,name,C,HA)
V = [X(1), -1; X(2), -1; X(2), 1; X(1), 1];

F = [1,2,3,4];

patch('Vertices',V,'Faces',F,'EdgeColor','none',...
    'FaceColor',C,'FaceAlpha',0.75);


xlim=get(HA,'XLim');
ylim=get(HA,'YLim');
X = lerp(X(1),X(2),0.3);
ht = text(X-0.15*X,0.6*ylim(1)+0.4*ylim(2)+1.5,['\scriptsize ',name]);
set(ht,'Rotation',70)
end


function y = db(x)
y = log(x)/log(10);
end

