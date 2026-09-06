function export_ieee(fig,baseName)
P = paper_params();
set(fig,'PaperPositionMode','auto'); drawnow;
exportgraphics(fig,[baseName '.pdf'],'ContentType','vector','BackgroundColor','white');
exportgraphics(fig,[baseName '.png'],'Resolution',P.pngDPI,'BackgroundColor','white');
print(fig,[baseName '.eps'],'-depsc2','-painters');
end
