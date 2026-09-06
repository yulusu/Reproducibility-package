function verify_paper_values()
%VERIFY_PAPER_VALUES Assertions for closed-form/numerical values reported in the manuscript.
tol = 5e-7;

% Planar compact-window benchmark: beta=2, mu=1.2.
beta = 2; mu = 1.2;
Disc = 1 - 3*beta^2 + 2*beta + 4*beta*mu;
am = (1 + beta*(1+2*mu))/(2*beta^2);
ap = (1 + beta*(1+2*mu) + sqrt(Disc))/(2*beta^2);
an = (1 + beta*(1+2*mu) - sqrt(Disc))/(2*beta^2);
assert(abs(an - 0.7734435563) < tol);
assert(abs(ap - 1.1765564437) < tol);
assert(abs(am - 0.975) < tol);

% Three-dimensional perturbed authority endpoint.
ep = 0.5;
critFun = @(al) sqrt(al.^2-1).*(1+ep*(1-1./al.^2))-1;
acrit = fzero(critFun,[1.00001 2]);
assert(abs(acrit - 1.2998959) < 2e-7);

% Polar-family critical authority.
c = 0.25; a = 1;
ac = a/(1-2*c);
assert(abs(ac - 2) < eps);

disp('All manuscript-value assertions passed.');
end
