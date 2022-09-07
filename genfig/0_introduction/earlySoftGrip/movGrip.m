clr; 
%%
name0 = 'im';

for ii = 1:16
   I{ii} = imread([name0,num2str(ii-1),'.jpg']);
end

f = fig(101,[10,8.85]); axis off;
ha = tight_subplot(2,4,[.01 .01],[.01 .01],[.01 .01]);

t = linspace(0,4,30);

jj = 1;
for ii = [4,5,6,8,9,10,11,13]
   axes(ha(jj)); 
   imshow(I{ii}); hold on;
   plot(0,0,'w.');
   drawnow;
   text(7,209,strcat("\scriptsize $t = ",strcat(num2str(t(ii)-t(4),2),"$ s")),...
       'Color','w','interpreter','latex')
   jj = jj +1;
end

%%
pause(0.1);
thesispath = @(x) ['~/Documents/phd/thesis/3_chapters/',x];

W0 = 0.9;
X = num2str(W0,4);
Y = num2str((f.InnerPosition(4)/f.InnerPosition(3))*W0,4);

cleanfigure('targetResolution',100);
matlab2tikz(thesispath('0_introduction/img/fig_first_gripper.tex'),...
     'width',[X,'\textwidth'],'height',[Y,'\textwidth']);