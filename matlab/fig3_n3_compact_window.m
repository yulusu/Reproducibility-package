function fig3_n3_compact_window()
P=paper_params(); ep=P.epsilon_p; a=linspace(1.001,3,600);
sF=asin(1./a); y=(-1+sqrt(1+4*a.^2))./(2*a.^2); sHlo=asin(sqrt(y));
sHhi=zeros(size(a));
for k=1:numel(a)
    fun=@(s)cos(s).*(1+ep*cos(s).^2)./sin(s).^2-a(k);
    sHhi(k)=fzero(fun,[1e-6 pi/2-1e-6]);
end
critFun=@(al)sqrt(al.^2-1).*(1+ep*(1-1./al.^2))-1;
acrit=fzero(critFun,[1.00001 2]);
fig=ieee_figure('double',2.65); ax=axes(fig); hold(ax,'on');
plot(ax,a,sF,'DisplayName','Feasible front'); plot(ax,a,sHlo,'--','DisplayName','Holding lower front');
plot(ax,a,sHhi,'-.','DisplayName','Holding upper front, $\epsilon_p=0.5$');
xline(ax,sqrt(2),':','DisplayName','$\sqrt{2}$'); xline(ax,acrit,':','DisplayName','$\alpha_+(\epsilon_p)$');
xlim(ax,[1 3]); ylim(ax,[0 1.6]); xlabel(ax,'Authority $\alpha$','Interpreter','latex'); ylabel(ax,'Angular distance $s$ [rad]','Interpreter','latex');
grid(ax,'on'); legend(ax,'Location','northeast','NumColumns',3,'Box','off','Interpreter','latex');
export_ieee(fig,fullfile('..','figures','fig3_n3_compact_window'));
end
