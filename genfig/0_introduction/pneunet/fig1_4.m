clr;
%% simulation settings
P = 15*kpa;
W = 120;
H = 20;

%% finite element settings
Simp  = 0.02;
GrowH = 1;
MinH  = 1.5;
MaxH  = 2.5;

%% generate mesh
msh = Mesh('PneunetFine.png','BdBox',[0,W,0,H],...
    'SimplifyTol',Simp,'Hmesh',[GrowH,MinH,MaxH]);

msh = msh.generate();

figure(101);
subplot(2,1,1); imshow('Pneunet.png');
subplot(2,1,2); msh.show();

%% generate fem model
fem = Fem(msh);
fem = fem.set('TimeStep',1/60,'TimeEnd',1,...
    'ResidualNorm',1e-1,'Linestyle','none');

%% add boundary constraint
fem = fem.addSupport(fem.FindNodes('Left'),[1,1]);
fem = fem.addPressure(fem.FindEdges('Hole'),P);

%% assign material
fem.Material = Dragonskin10();

%% solve
fem.solve();

%%
p = fem.Log.t*P;
dV = sum(fem.Log.Volume - fem.Log.Volume(1,:),2);

id = fem.FindNodes('SE');

for ii = 1:numel(p)
   RR = fem.Log.Rotation{ii};
   dX(ii) = atan2(RR{id}(2,1),RR{id}(1,1));
end

dX = unwrap(-dX);

%%
f = fig(103,[10,9]);
jj = 1;
I = [];
D = 10;
for ii = [1,15,30,60]
    %subplot(1,6,jj);
    nds = fem.Log.Node{ii};
    fem.set('Node',nds);
    fem.show('Field',fem.Log.Stress{ii});
    axis([-30 130 -100 30]);   
    background();
    drawnow();
    %axis tight;
    
    B = boxhull(nds);
    B(3) = B(3) - D;
    B(4) = B(4) + D;
    B(1) = -30;
    B(2) = 120;
    
    W = B(2)-B(1);
    
    axis(B);
  
    %axis equal;
    drawnow limitrate;
    F = getframe;
    img = (frame2im(F));
    I{jj,1} = imresize(img,[NaN 650],'bicubic'); 
    
    %axis tight;
    jj = jj + 1;
end

clf;
out = cat(1,I{:});
imshow(out);

close(103);

%%
f = fig(104,[10.15,9.5]); clf;
subplot_tight(1,7,1:4,0.02);
imshow(out);

subplot_tight(1,7,5:7,[0.1,0.05]);
sorocolor
plot(p/kpa,dV/3,'LineW',1.5); hold on;
ax = gca();
ax.YRuler.TickLabelFormat = '%.1f';

plot(p/kpa,dX*(180/pi),'Color',col(2),'LineW',1.5);
% [~,I] = min(abs(gradient(dX)));
% plot(p(1:I),dX(1:I)-dX(1),'Color',col(2),'LineW',1.5);
% plot(p(I:end),dX(I:end)-dX(1),'--','Color',col(2),'LineW',1.5);
% legend({'volume','\delta \!\!L'},'Orientation','Horizontal','Location','NW');

grid on;
box on;
set(gca,'LineW',1.5);
xlabel('pressure (kPa)');
axis([0 15 0 350]);

% %
% thesispath = @(x) ['~/Documents/phd/thesis/3_chapters/',x];
% 
% W0 = 0.95;
% X = num2str(W0,4);
% Y = num2str((f.InnerPosition(4)/f.InnerPosition(3))*W0,4);
% 
% cleanfigure('targetResolution', 100);
% matlab2tikz(thesispath('0_introduction/img/fig_1_1.tex'),...
%      'width',[X,'\textwidth'],'height',[Y,'\textwidth']);
%      %'extraAxisOptions','ylabel style={yshift=-7.5pt}',...
%      %'showInfo', false);
