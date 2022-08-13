clr;
%% generate mesh from sdf
P = 0.075*kpa;  % pressure
W = 35;     % width
H = 80;     % heigth
% T = 2;      % thickness
% O = 0;      % horizontal offsett

Material = Ecoflex0030(15);

I = imread('swr.png');

img = [];
for ii = 1:6
    img = cat(1,img,I);
end


% sdf = sRectangle(0,W,0,H) - sRectangle(T-O,W-T-O,5,H-5) + ...
%     sRectangle(0,W,H/3 - T/4,H/3 + T/4) + ...
%     sRectangle(0,W,2*H/3 - T/4,2*H/3 + T/4);

msh = Mesh(img,'BdBox',[0,W,0,H],'BdBox',[0,W,0,H],...
    'SimplifyTol',0.07,'Hmesh',[1,1,2]);
msh = msh.generate();
msh.show;

%% generate fem model from mesh
fem = Fem(msh,'TimeStep',1/150,'Linestyle','none',...
    'ResidualNorm',1e-2,'Penal',2);

%% add constraint
fem = fem.addSupport(fem.FindNodes('Top'),[1,1]);
fem = fem.addSupport(fem.FindNodes('Bottom'),[1,0]);
fem = fem.addPressure(fem.FindEdges('Hole'),-P);
%fem = fem.addPressure(fem.FindEdges('Hole',[3]),-0.1*P);

%% select material
fem.Material = Material;

% box = sRectangle(T,W-T,5,H-5);
% D = box.eval(fem.Center); 
% List = D(:,end) < 0;

%fem.Density(List) = 0.3;

%% solving
fem.solve();

%%
figure(106); clf;
p  = fem.Log.t*P/kpa;
id = fem.FindNodes('Bottom');

dV = sum(fem.Log.Volume,2); dV = dV - dV(1);
dX = zeros(numel(p),1);

for ii = 1:numel(p)
   dX(ii) = mean(fem.Log.Node{ii}(id,2));
end

%dX = clamp(dX,eps,Inf);

%%
f = fig(103);
jj = 1;
I = [];
D = 8;
for ii = round(linspace(1,150,5))
    %subplot(1,6,jj);
    nds = fem.Log.Node{ii};
    fem.set('Node',nds);
    fem.show('Field',fem.Log.Stress{ii});
    axis([-35,55,0,80]);
    %caxis([-1,45]/1e3);
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
subplot_tight(1,7,1:4,0.005);
imshow(out);
a = 20;
subplot_tight(1,7,5:7,[0.1,0.1]);
sorocolor
plot(p*a,smoothclamp(dV/100,-7,1,1),'LineW',1.5); hold on;
ax = gca();
ax.YRuler.TickLabelFormat = '%.1f';

%plot([100 1800],[-10,-10],'-k');

[~,I] = mink(abs(gradient(dX)),10);
I = I(min(find(I > 6)));

plot(p*a,smoothclamp(dX-dX(1),0,30),'Color',col(2),'LineW',1.5);
%plot(p(I:end),dX(I:end)-dX(1),'--','Color',col(2),'LineW',1.5);
legend({'volume','\delta \!\!L'},'Orientation','Horizontal','Location','NW');

grid on;
box on;
set(gca,'LineW',1.5);
xlabel('pressure (kPa)');
annotation('arrow',[0.06,0.55],[0.03,0.03],...%'String','time ',...
    'Color',lightgrey,'LineW',1);
% 
annotation('textbox',[0.0,0.11,0.06,0.06],'String','\scriptsize time ',...
     'Color',lightgrey,'EdgeColor','none');

axis([0 1.5 -10 48]);

%
thesispath = @(x) ['~/Documents/phd/thesis/3_chapters/',x];

W0 = 0.95;
X = num2str(W0,4);
Y = num2str((f.InnerPosition(4)/f.InnerPosition(3))*W0,4);

cleanfigure('targetResolution', 100);
matlab2tikz(thesispath('0_introduction/img/fig_bellow.tex'),...
     'width',[X,'\textwidth'],'height',[Y,'\textwidth']);
%      'extraAxisOptions','ylabel style={yshift=-7.5pt}',...
%      'showInfo', false);
