clr;
%% generate mesh
Simp  = 0.08;
GrowH = 1;

MinH  = 6;
MaxH  = 8;

msh = Mesh('SRPlanar.png',...
    'BdBox',[0,250,0,290],...
    'SimplifyTol',Simp,...
    'Hmesh',[GrowH,MinH,MaxH]);

msh = msh.generate();
msh.show();
msh.show('Holes');

%% pressure sets
P0    = 2*kpa;
pset0 = [23,21,18,15,12,9,6,3,...
         25,22,19,16,13,10,7,4];

%% generate fem model
fem = Fem(msh);
fem = fem.set('TimeStep',1/50,...
              'BdBox',[0,108,0,325],...
              'Linestyle','none',...
              'MovieAxis',[-25 120 -60 130],...
              'Movie',0,'TimeEnd',4);

%% add boundary constraint
fem = fem.addSupport(fem.FindNodes('Bottom'),[1,1]);
fem = fem.addSupport(fem.FindNodes('Top'),[1,0]);
fem = fem.addPressure(fem.FindEdges('Hole',...
    pset0), @(x) P0*sigmoid(x.Time));

%% assign material
fem.Material = NeoHookeanMaterial(2,0.25);  
fem.Material.Zeta = 0.35;

%% solve
fem.solve(); 

%% extract data
p  = fem.Log.t*P0/kpa;
id = fem.FindNodes('TopMid');

dV = sum(fem.Log.Volume(:,pset0),2); 
dV = dV - dV(1);

dX = zeros(numel(p),1);

for ii = 1:numel(p)
    dX(ii) = fem.Log.Node{ii}(id,2);
    %dX(ii) = acos(R(:,1).'*[1;0;0]);
end

%%
f = fig(103);
jj = 1;
I = [];
D = 35;
for ii = [1,10,25,50]
    %subplot(1,6,jj);
    nds = fem.Log.Node{ii};
    fem.set('Node',nds);
    %fem.show('Field',fem.Log.Stress{ii});
    fem.show('Un');
    axis([0,350,0,400]);
    background();
    %caxis([-1,45]/1e3);
    %axis tight;
    
    B = boxhull(nds);
    B(1) = B(1) - 0.25*D;
    B(2) = B(2) + D;
    B(3) = 0;
    B(4) = 400;
    
    W = B(2)-B(1);
    
    axis(B);
    colormap(barney(-1))
  
    %axis equal;
    drawnow limitrate;
    F = getframe;
    img = (frame2im(F));
    I{jj,1} = imresize(img,[650 NaN],'bicubic'); 
    
    %axis tight;
    jj = jj + 1;
end

clf;
out = cat(2,I{:});
imshow(out);

%%

f = fig(104,[10.75,8.6]); clf;
subplot_tight(1,7,1:4,0.02);
imshow(out);

subplot_tight(1,7,5:7,[0.1,0.1]);
sorocolor
plot(p*7.5,dV/120,'LineW',1.5); hold on;
ax = gca();
ax.YRuler.TickLabelFormat = '%.1f';

[~,I] = min(abs(gradient(dX)));
plot(p*7.5,(dX - dX(1))/1.25,'Color',col(2),'LineW',1.5);
% plot(p(I:end),dX(I:end)-dX(1),'--','Color',col(2),'LineW',1.5);
legend({'volume','$\delta L$'},'Orientation','Horizontal',...
    'Location','NW','interpreter','latex');

grid on;
box on;
set(gca,'LineW',1.5);
%xlabel('pressure (kPa)');
axis([0 15 0 110]);
sorocolor;

%%
% % %
% thesispath = @(x) ['~/Documents/phd/thesis/3_chapters/',x];
% 
% W0 = 0.95;
% X = num2str(W0,4);
% Y = num2str((f.InnerPosition(4)/f.InnerPosition(3))*W0,4);
% 
% cleanfigure('targetResolution', 100);
% matlab2tikz(thesispath('0_introduction/img/fig_orm_elong.tex'),...
%      'width',[X,'\textwidth'],'height',[Y,'\textwidth']);

