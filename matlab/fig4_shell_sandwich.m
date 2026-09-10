function fig4_shell_sandwich()
%FIG4_SHELL_SANDWICH Exact boundary functions with identical shell data.
% Reviewer-requested comparison for Proposition 4.
P = paper_params();
c = P.cShell;
alpha = P.alphaShell;
OmegaVals = P.OmegaShell;

theta = linspace(0,2*pi,241);
Z = zeros(numel(OmegaVals),numel(theta));
for j = 1:numel(OmegaVals)
    Om = OmegaVals(j);
    for k = 1:numel(theta)
        Z(j,k) = threshold_Z(theta(k),Om,c,alpha);
    end
end

fig = ieee_figure('double',2.55);
ax = axes(fig); hold(ax,'on');
plot(ax,theta/pi,Z(1,:),'DisplayName','$\Omega=0$');
plot(ax,theta/pi,Z(2,:),'--','DisplayName','$\Omega=1.2>c/2$');
yline(ax,alpha/(2*c),':','DisplayName','$\alpha/(2c)$');
yline(ax,alpha/c,'-.','DisplayName','$\alpha/c$');
xlim(ax,[0 2]);
ylim(ax,[0.9*alpha/(2*c) 1.05*alpha/c]);
xticks(ax,[0 0.5 1 1.5 2]);
xlabel(ax,'$\theta/\pi$','Interpreter','latex');
ylabel(ax,'Exact threshold $Z(\theta)$','Interpreter','latex');
grid(ax,'on');
legend(ax,'Location','best','NumColumns',2,'Box','off','Interpreter','latex');

export_ieee(fig,fullfile('..','figures','fig4_shell_sandwich'));
end

function z = threshold_Z(theta0,Omega,c,alpha)
%THRESHOLD_Z Evaluate Z(theta0) from the integral in Proposition 4.
thetaRate = Omega - 0.5*c*sin(2*theta0);
kappa0 = c*(1+sin(theta0)^2);

% At an equilibrium of theta, the integral is analytic.
if abs(thetaRate) < 1e-12
    z = alpha/kappa0;
    return;
end

% Integrate theta, accumulated exponent K, and the threshold integral I.
rhs = @(t,y) [ ...
    Omega - 0.5*c*sin(2*y(1)); ...
    c*(1+sin(y(1))^2); ...
    alpha*exp(-y(2)) ...
    ];
opts = odeset('RelTol',1e-9,'AbsTol',1e-11,'MaxStep',0.05);
[~,Y] = ode45(rhs,[0 30],[theta0;0;0],opts);
z = Y(end,3);
end
