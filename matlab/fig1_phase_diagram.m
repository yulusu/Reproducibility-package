function fig1_phase_diagram()
%FIG1_PHASE_DIAGRAM Phase diagram with automatic, geometry-based labels.
%
% The label locations are computed from the plotted geometry rather than
% fixed by hand.  This avoids manual nudging and keeps the annotations
% separated when the figure size or font metrics change.

b = linspace(0.12,1.8,500);
U = 0.75*b - 0.5;
L = -0.75*b - 0.5;
E = 0.75*b - 0.5 - 1./(4*b);

fig = ieee_figure('single',2.55);
ax = axes(fig);
hold(ax,'on');

plot(ax,b,U);
plot(ax,b,L,'--');
plot(ax,b,E,':');
plot(ax,1,-0.1,'o','MarkerSize',4);

xlim(ax,[0.12 1.8]);
ylim(ax,[-2.1 1]);
xlabel(ax,'$\beta$','Interpreter','latex');
ylabel(ax,'$\mu$','Interpreter','latex');
grid(ax,'on');

% Force final axes geometry before placing any annotation.
drawnow;

% Curves used both for curve labels and as obstacles for region labels.
curves = { ...
    [b(:), U(:)], ...
    [b(:), L(:)], ...
    [b(:), E(:)]  ...
    };

% ---- Curve labels: choose the clearest point on each curve automatically.
curveSpecs = { ...
    '$U_{\rm on}$', curves{1}, +1; ...
    '$E_{\rm fr}$', curves{3}, +1; ...
    '$L_{\rm on}$', curves{2}, +1  ...
    };

labelPts = zeros(0,2);
for k = 1:size(curveSpecs,1)
    label = curveSpecs{k,1};
    xy = curveSpecs{k,2};
    side = curveSpecs{k,3};
    [xLab,yLab] = auto_curve_label(ax,xy,curves,[1 -0.1],labelPts,side);
    text(ax,xLab,yLab,label, ...
        'Interpreter','latex', ...
        'HorizontalAlignment','center', ...
        'VerticalAlignment','middle');
    labelPts(end+1,:) = [xLab,yLab]; %#ok<AGROW>
end

% ---- Region labels: search the admissible region for maximum clearance.
regionSpecs = { ...
    '$C_+$', @(x,y) y > 0.75*x-0.5; ...
    'A',     @(x,y) y < 0.75*x-0.5 & y > (-0.75*x-0.5); ...
    'B',     @(x,y) y < (-0.75*x-0.5) & y > (0.75*x-0.5-1./(4*x)); ...
    '$C_-$', @(x,y) y < 0.75*x-0.5 & y < (0.75*x-0.5-1./(4*x)) & x < 0.50; ...
    'D',     @(x,y) y < (-0.75*x-0.5) & y < (0.75*x-0.5-1./(4*x)) ...
    };

for k = 1:size(regionSpecs,1)
    label = regionSpecs{k,1};
    inside = regionSpecs{k,2};
    [xLab,yLab] = auto_region_label(ax,inside,curves,[1 -0.1],labelPts);
    text(ax,xLab,yLab,label, ...
        'Interpreter','latex', ...
        'HorizontalAlignment','center', ...
        'VerticalAlignment','middle');
    labelPts(end+1,:) = [xLab,yLab]; %#ok<AGROW>
end

% ---- Example label: automatically choose the least crowded of several
% relative offsets around the marker, instead of a fixed text coordinate.
[xEx,yEx] = auto_point_label(ax,[1 -0.1],curves,labelPts);
text(ax,xEx,yEx,'example', ...
    'HorizontalAlignment','center', ...
    'VerticalAlignment','middle');

export_ieee(fig,fullfile('..','figures','fig1_phase_diagram'));
end


function [xLab,yLab] = auto_curve_label(ax,xy,curves,pointObstacle,labelPts,side)
% Select a point on a curve with high clearance from all other geometry,
% then move a small normalized distance along the local curve normal.

xl = xlim(ax); yl = ylim(ax);
sx = diff(xl); sy = diff(yl);

% Avoid plot edges, where labels are likely to be clipped.
valid = xy(:,1) > xl(1)+0.12*sx & xy(:,1) < xl(2)-0.12*sx & ...
        xy(:,2) > yl(1)+0.10*sy & xy(:,2) < yl(2)-0.10*sy;
idx = find(valid);
if isempty(idx)
    idx = (1:size(xy,1)).';
end

% Downsample candidates for efficiency.
step = max(1,round(numel(idx)/120));
idx = idx(1:step:end);

bestScore = -inf;
best = idx(1);

for ii = idx(:).'
    p = xy(ii,:);
    pn = [(p(1)-xl(1))/sx, (p(2)-yl(1))/sy];

    d = inf;

    % Distance to the other curves (ignore the local neighborhood on the
    % current curve itself by simply considering all curves and then
    % allowing a small normal offset below).
    for c = 1:numel(curves)
        q = curves{c};
        qn = [(q(:,1)-xl(1))/sx, (q(:,2)-yl(1))/sy];
        dc = min(hypot(qn(:,1)-pn(1), qn(:,2)-pn(2)));
        if isequal(q,xy)
            % Self-distance is zero and carries no information.
            dc = inf;
        end
        d = min(d,dc);
    end

    po = [(pointObstacle(1)-xl(1))/sx, (pointObstacle(2)-yl(1))/sy];
    d = min(d,hypot(po(1)-pn(1),po(2)-pn(2)));

    if ~isempty(labelPts)
        lp = [(labelPts(:,1)-xl(1))/sx, (labelPts(:,2)-yl(1))/sy];
        d = min(d,min(hypot(lp(:,1)-pn(1),lp(:,2)-pn(2))));
    end

    % Edge clearance.
    edge = min([pn(1),1-pn(1),pn(2),1-pn(2)]);
    score = d + 0.40*edge;

    if score > bestScore
        bestScore = score;
        best = ii;
    end
end

% Local tangent and normalized normal.
i1 = max(1,best-1);
i2 = min(size(xy,1),best+1);
dx = (xy(i2,1)-xy(i1,1))/sx;
dy = (xy(i2,2)-xy(i1,2))/sy;
n = side*[-dy, dx];
n = n/max(norm(n),eps);

offset = 0.045;  % normalized axes units, independent of physical size
pn = [(xy(best,1)-xl(1))/sx, (xy(best,2)-yl(1))/sy] + offset*n;

xLab = xl(1) + pn(1)*sx;
yLab = yl(1) + pn(2)*sy;
end


function [xLab,yLab] = auto_region_label(ax,inside,curves,pointObstacle,labelPts)
% Search a regular candidate grid inside the requested region and maximize
% normalized clearance from curves, marker, previous labels, and axes edges.

xl = xlim(ax); yl = ylim(ax);
sx = diff(xl); sy = diff(yl);

xg = linspace(xl(1)+0.08*sx,xl(2)-0.08*sx,85);
yg = linspace(yl(1)+0.08*sy,yl(2)-0.08*sy,85);
[X,Y] = meshgrid(xg,yg);

mask = inside(X,Y) & isfinite(X) & isfinite(Y);
cand = [X(mask),Y(mask)];

if isempty(cand)
    error('No candidate location found for a region label.');
end

cn = [(cand(:,1)-xl(1))/sx, (cand(:,2)-yl(1))/sy];
score = inf(size(cand,1),1);

% Clearance from every plotted curve.
for c = 1:numel(curves)
    q = curves{c};
    qn = [(q(:,1)-xl(1))/sx, (q(:,2)-yl(1))/sy];
    dc = inf(size(cand,1),1);
    for j = 1:size(qn,1)
        dc = min(dc,hypot(cn(:,1)-qn(j,1),cn(:,2)-qn(j,2)));
    end
    score = min(score,dc);
end

% Clearance from the example marker.
po = [(pointObstacle(1)-xl(1))/sx, (pointObstacle(2)-yl(1))/sy];
score = min(score,hypot(cn(:,1)-po(1),cn(:,2)-po(2)));

% Clearance from already placed labels.
if ~isempty(labelPts)
    lp = [(labelPts(:,1)-xl(1))/sx, (labelPts(:,2)-yl(1))/sy];
    for j = 1:size(lp,1)
        score = min(score,hypot(cn(:,1)-lp(j,1),cn(:,2)-lp(j,2)));
    end
end

% Favor interior positions and avoid labels hugging the axes.
edge = min([cn(:,1),1-cn(:,1),cn(:,2),1-cn(:,2)],[],2);
score = score + 0.30*edge;

[~,i] = max(score);
xLab = cand(i,1);
yLab = cand(i,2);
end


function [xLab,yLab] = auto_point_label(ax,p,curves,labelPts)
% Choose the clearest relative offset around a marked point.

xl = xlim(ax); yl = ylim(ax);
sx = diff(xl); sy = diff(yl);
pn = [(p(1)-xl(1))/sx, (p(2)-yl(1))/sy];

offsets = [ ...
     0.060  0.055; ...
     0.060 -0.055; ...
    -0.060  0.055; ...
    -0.060 -0.055; ...
     0.000  0.085; ...
     0.000 -0.085; ...
     0.090  0.000; ...
    -0.090  0.000];

bestScore = -inf;
best = offsets(1,:);

for k = 1:size(offsets,1)
    qn = pn + offsets(k,:);

    % Keep candidate safely inside axes.
    if any(qn < 0.06) || any(qn > 0.94)
        continue;
    end

    score = inf;

    for c = 1:numel(curves)
        q = curves{c};
        qc = [(q(:,1)-xl(1))/sx, (q(:,2)-yl(1))/sy];
        score = min(score,min(hypot(qc(:,1)-qn(1),qc(:,2)-qn(2))));
    end

    if ~isempty(labelPts)
        lp = [(labelPts(:,1)-xl(1))/sx, (labelPts(:,2)-yl(1))/sy];
        score = min(score,min(hypot(lp(:,1)-qn(1),lp(:,2)-qn(2))));
    end

    edge = min([qn(1),1-qn(1),qn(2),1-qn(2)]);
    score = score + 0.25*edge;

    if score > bestScore
        bestScore = score;
        best = offsets(k,:);
    end
end

qn = pn + best;
xLab = xl(1) + qn(1)*sx;
yLab = yl(1) + qn(2)*sy;
end
