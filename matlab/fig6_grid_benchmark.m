function fig6_grid_benchmark()
P=paper_params(); beta=P.betaGrid; mu=P.muGrid; A=P.alphaGrid; Ns=P.Ngrid;
exactLeft=@(al)max(mu-beta*al,-0.5-sqrt(al-0.75));
h=zeros(size(Ns)); err=zeros(size(Ns));
for j=1:numel(Ns)
    emax=0; hmax=0;
    for k=1:numel(A)
        ell=mu-beta*A(k); rr=mu+beta*A(k); hh=(rr-ell)/(Ns(j)-1);
        xg=grid_viability_left(A(k),beta,mu,Ns(j));
        emax=max(emax,abs(xg-exactLeft(A(k)))); hmax=max(hmax,hh);
    end
    h(j)=hmax; err(j)=emax;
end
ref=err(end)*(h/h(end));
fig=ieee_figure('double',2.55); ax=axes(fig); hold(ax,'on');
loglog(ax,h,err,'o-','DisplayName','Maximum boundary error');
loglog(ax,h,ref,'--','DisplayName','$O(h)$ reference');
xlabel(ax,'Maximum grid spacing $h$','Interpreter','latex'); ylabel(ax,'Boundary error'); grid(ax,'on');
legend(ax,'Location','northwest','Box','off','Interpreter','latex');
export_ieee(fig,fullfile('..','figures','fig6_grid_benchmark'));
end
