function fig5_mainiv_witness()
P=paper_params(); c=P.cIFT; aa=P.aIFT; ac=P.alphaIFT; th=linspace(0,2*pi,800);
D=c*ac*(1+sin(th).^2)+aa*sin(th);
fig=ieee_figure('single',2.45); ax=axes(fig); hold(ax,'on');
plot(ax,th,D,'DisplayName','Northern-latitude demand');
yline(ax,ac,':','DisplayName','$\alpha_c$'); xline(ax,pi/2,'--','DisplayName','$\theta_c=\pi/2$');
xlim(ax,[0 2*pi]); xticks(ax,[0 pi/2 pi 3*pi/2 2*pi]); xticklabels(ax,{'0','$\pi/2$','$\pi$','$3\pi/2$','$2\pi$'});
set(ax,'TickLabelInterpreter','latex'); xlabel(ax,'Azimuth $\theta$','Interpreter','latex'); ylabel(ax,'Demand'); grid(ax,'on');
legend(ax,'Location','southwest','Box','off','Interpreter','latex');
export_ieee(fig,fullfile('..','figures','fig5_mainiv_witness'));
end
