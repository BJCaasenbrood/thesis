clr; 
PRINT = false;
% name0 = 'im';
% 
% for ii = 1:16
%    I{ii} = imread([name0,num2str(ii-1),'.jpg']);
% end
% 
% f = fig(101,[10,8.85]); axis off;
% ha = tight_subplot(2,4,[.01 .01],[.01 .01],[.01 .01]);
% 
% t = linspace(0,14,16);
% 
% jj = 1;
% for ii = [1,3,4,7,8,11,12,16]
%    axes(ha(jj)); 
%    imshow(I{ii}); hold on;
%    plot(0,0,'w.');
%    drawnow;
%    text(15,320,strcat("\scriptsize $t = ",strcat(num2str(t(ii),2),"$ s")),...
%        'Color','w','interpreter','latex')
%    jj = jj +1;
% end
I = cell(0);

W = 255*uint8(ones(650,30,3));


I{end+1} = imresize(imread('image1005.png'),[650,nan]); I{end+1} = W;
I{end+1} = imresize(imread('img10.png'),[650,nan]); I{end+1} = W;
%I{end+1} = imresize(imread('img4.jpeg'),[650,nan]); I{end+1} = W;
I{end+1} = imresize(imread('img1.png'),[650,nan]); I{end+1} = W;
I{end+1} = imresize(imread('img22.png'),[650,nan]); I{end+1} = W;
I{end+1} = imresize(imread('img77.png'),[650,nan]); %I{end+1} = W;


f = fig(101,[11,10]);
%montage(I,'BackgroundColor','w','Size', [1 5]);
IMG = cat(2,I{:});
imshow(IMG);

W = -120;
H = 780;
W = 10;
H = 60;
% text(W+ size(I{1},2)/2,H,'\small (a)','Color','k'); W = W + size(I{1},2) + 30;
% text(W+ size(I{3},2)/2,H,'\small (b)','Color','k'); W = W + size(I{3},2) + 30;
% text(W+ size(I{5},2)/2,H,'\small (c)','Color','k'); W = W + size(I{5},2) + 30;
% text(W+ size(I{7},2)/2,H,'\small (d)','Color','k'); W = W + size(I{7},2) + 30;
% text(W+ size(I{9},2)/2,H,'\small (e)','Color','k');
text(W,H,'\textbf a','Color','w'); W = W + size(I{1},2) + 30;
text(W,H,'\textbf b','Color','w'); W = W + size(I{3},2) + 30;
text(W,H,'\textbf c','Color','w'); W = W + size(I{5},2) + 30;
text(W,H,'\textbf d','Color','k'); W = W + size(I{7},2) + 30;
text(W,H,'\textbf e','Color','w');




%%
pause(0.1);
thesispath = @(x) ['~/Documents/phd/thesis/3_chapters/',x];

W0 = 0.975;
X = num2str(W0,4);
Y = num2str((f.InnerPosition(4)/f.InnerPosition(3))*W0,4);

%cleanfigure('targetResolution', 100);
if PRINT
matlab2tikz(thesispath('0_introduction/img/fig_actuation_types.tex'),...
     'width',[X,'\textwidth'],'height',[Y,'\textwidth']);
 
end