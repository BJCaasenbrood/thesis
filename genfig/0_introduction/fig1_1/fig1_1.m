clr;
%% generate mesh from sdf
P = 1.5*kpa;  % pressure
W = 15;     % width
H = 80;     % heigth
T = 2;      % thickness
O = 0;      % horizontal offsett

Material = Ecoflex0030(5);

sdf = sRectangle(0,W,0,H) - sRectangle(T-O,W-T-O,5,H-5);
msh = Mesh(sdf,'BdBox',[0,W,0,H],'NElem',1e3);
msh = msh.generate();
msh.show;

%% generate fem model from mesh
fem = Fem(msh,'TimeStep',1/250,'Linestyle','none',...
    'ResidualNorm',1e-1,'Penal',4);

%% add constraint
fem = fem.addSupport(fem.FindNodes('Top'),[1,1]);
fem = fem.addSupport(fem.FindNodes('Bottom'),[1,0]);
fem = fem.addPressure(fem.FindEdges('Hole'),P);

%% select material
fem.Material = Material;

% box = sRectangle(0,T,5,H-5);
% D = box.eval(fem.Center); 
% List = D(:,end) < 0;
% 
% fem.Density(List) = 0.5;

%% solving
fem.solve();

%%
figure(106); clf;
p  = fem.Log.t*P/kpa;
id = fem.FindNodes('Bottom');

dV = fem.Log.Volume - fem.Log.Volume(1);
dX = zeros(numel(p),1);

for ii = 1:numel(p)
   dX(ii) = mean(fem.Log.Node{ii}(id,2));
end

%%
f = fig(103);
jj = 1;
I = [];
D = 10;
for ii = [1,3,15,50,251]
    %subplot(1,6,jj);
    nds = fem.Log.Node{ii};
    fem.set('Node',nds);
    fem.show('Field',fem.Log.Stress{ii});
    axis([-35,55,0,80]);
    caxis([-1,45]/1e3);
    %axis tight;
    
    B = boxhull(nds);
    B(1) = B(1) - D;
    B(2) = B(2) + D;
    B(3) = - 5;
    B(4) = 80;
    
    W = B(2)-B(1);
    
    axis(B);
  
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

close(103);

%%
f = fig(104,[10.75,8.6]); clf;
subplot_tight(1,7,1:4,0.001);
imshow(out);

subplot_tight(1,7,5:7,[0.1,0.1]);
sorocolor
plot(p,dV/100,'LineW',1.5); hold on;
ax = gca();
ax.YRuler.TickLabelFormat = '%.1f';

[~,I] = min(abs(gradient(dX)));
plot(p(1:I),dX(1:I)-dX(1),'Color',col(2),'LineW',1.5);
plot(p(I:end),dX(I:end)-dX(1),'--','Color',col(2),'LineW',1.5);
legend({'volume','\delta \!\!L'},'Orientation','Horizontal','Location','NW');

grid on;
box on;
set(gca,'LineW',1.5);
xlabel('pressure (kPa)');
axis([0 1.5 0 35]);


% %%
% thesispath = @(x) ['~/Documents/phd/thesis/3_chapters/',x];
% 
% W0 = 0.95;
% X = num2str(W0,4);
% Y = num2str((f.InnerPosition(4)/f.InnerPosition(3))*W0,4);
% 
% cleanfigure('targetResolution', 100);
% matlab2tikz(thesispath('0_introduction/img/fig_1_1.tex'),...
%      'width',[X,'\textwidth'],'height',[Y,'\textwidth']);
     %'extraAxisOptions','ylabel style={yshift=-7.5pt}',...
     %'showInfo', false);
