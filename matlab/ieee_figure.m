function fig = ieee_figure(widthType,heightIn)
P = paper_params();
switch lower(widthType)
    case 'single', widthIn = P.singleWidthIn;
    case 'double', widthIn = P.doubleWidthIn;
    otherwise, error('widthType must be single or double');
end
set(groot,'defaultAxesFontName','Times New Roman');
set(groot,'defaultTextFontName','Times New Roman');
set(groot,'defaultAxesFontSize',P.figFontPt);
set(groot,'defaultTextFontSize',P.figFontPt);
set(groot,'defaultLegendFontSize',P.figFontPt);
set(groot,'defaultAxesLineWidth',0.75);
set(groot,'defaultLineLineWidth',1.15);
fig = figure('Units','inches','Position',[1 1 widthIn heightIn], ...
    'Color','w','Renderer','painters');
end
