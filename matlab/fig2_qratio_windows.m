function fig2_qratio_windows()
a=linspace(0.751,2,1000); D0=@(x)1+x+x.^2; Q=@(al,b,m)D0(m-b.*al)./al;
fig=ieee_figure('single',2.55); ax=axes(fig); hold(ax,'on');
semilogy(ax,a,Q(a,1,-0.1),'DisplayName','Region B: $(\beta,\mu)=(1,-0.1)$');
semilogy(ax,a,Q(a,2,1.2),'--','DisplayName','Compact window: $(\beta,\mu)=(2,1.2)$');
yline(ax,1,':','DisplayName','$\mathcal Q=1$');
xlim(ax,[0.75 2]); ylim(ax,[0.8 3]);
xlabel(ax,'Authority $\alpha$','Interpreter','latex'); ylabel(ax,'Normalized demand $\mathcal Q$','Interpreter','latex');
grid(ax,'on'); legend(ax,'Location','northwest','Box','off','Interpreter','latex');
export_ieee(fig,fullfile('..','figures','fig2_qratio_windows'));
end
