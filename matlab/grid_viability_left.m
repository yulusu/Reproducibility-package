function left = grid_viability_left(alpha,beta,mu,N)
%GRID_VIABILITY_LEFT Left boundary of the 1-D viability grid.
% The projective drift is strictly negative, so only the left feasible
% boundary can be lost in this benchmark.
ell=mu-beta*alpha; rr=mu+beta*alpha; x=linspace(ell,rr,N);
iL=1;
while iL<=N
    psiL=-(1+x(iL)+x(iL)^2);
    if psiL+alpha<0
        iL=iL+1;
    else
        break;
    end
end
if iL>N, left=NaN; else, left=x(iL); end
end
