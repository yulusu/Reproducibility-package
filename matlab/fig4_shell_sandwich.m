function fig4_shell_sandwich()
P=paper_params(); c=P.cShell; a=linspace(2,20,600);
sF=atan(1./a); sLo=atan(c./a); sHi=atan(2*c./a);
fig=ieee_figure('double',2.55); ax=axes(fig); hold(ax,'on');
plot(ax,a,sF,'DisplayName','Feasible front'); plot(ax,a,sLo,'--','DisplayName','Lower shell bound');
plot(ax,a,sHi,':','DisplayName','Upper shell bound');
xlim(ax,[2 20]); ylim(ax,[0 1.0]); xlabel(ax,'Authority $\alpha$','Interpreter','latex'); ylabel(ax,'Angular distance $s$ [rad]','Interpreter','latex');
grid(ax,'on'); legend(ax,'Location','northeast','NumColumns',3,'Box','off','Interpreter','latex');
export_ieee(fig,fullfile('..','figures','fig4_shell_sandwich'));
end
