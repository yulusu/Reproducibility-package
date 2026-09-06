function fig1_phase_diagram()
b=linspace(0.12,1.8,500);
U=0.75*b-0.5; L=-0.75*b-0.5; E=0.75*b-0.5-1./(4*b);
fig=ieee_figure('single',2.55); ax=axes(fig); hold(ax,'on');
plot(ax,b,U); plot(ax,b,L,'--'); plot(ax,b,E,':');
plot(ax,1,-0.1,'o','MarkerSize',4);
xlim(ax,[0.12 1.8]); ylim(ax,[-2.1 1]);
xlabel(ax,'$\beta$','Interpreter','latex'); ylabel(ax,'$\mu$','Interpreter','latex'); grid(ax,'on');
x=1.42; text(ax,x,0.75*x-0.5+0.08,'$U_{\rm on}$','Interpreter','latex');
x=0.63; text(ax,x,0.75*x-0.5-1/(4*x)+0.08,'$E_{\rm fr}$','Interpreter','latex');
x=1.35; text(ax,x,-0.75*x-0.5+0.06,'$L_{\rm on}$','Interpreter','latex');
text(ax,1.52,0.70,'$C_+$','Interpreter','latex');
text(ax,1.28,0.34,'A'); text(ax,1.20,-0.55,'B');
text(ax,0.23,-0.94,'$C_-$','Interpreter','latex'); text(ax,0.60,-1.72,'D');
text(ax,1.05,-0.28,'example');
export_ieee(fig,fullfile('..','figures','fig1_phase_diagram'));
end
