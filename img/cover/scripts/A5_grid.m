clr;
% params
isQuad = true;

% script to generate a A5 quad grid of transparant blocks
W = 148; % (mm)
H = 210; % (mm)
sdf = sRectangle(W,H);

% determine the grids
alpha = 0.1;
dist = round(alpha * [W,H]);

% meshing from SDF
if isQuad
    msh = Mesh(sdf,'Quads',dist);
else
    msh = Mesh(sdf,'NElem',dist(1) * dist(2));
    msh.solver.MaxIteration = 1e3;
end

msh = msh.generate();

% show mesh
h = msh.show('LineStyle','none');
delete(h{2});