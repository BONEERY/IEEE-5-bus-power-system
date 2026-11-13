clear;

%% Base values
fn = 50;
Vn = 121e3;
Sn = 100e6;
Zn = Vn^2/Sn;
In = Sn/(sqrt(3)*Vn);

t_cont = 100; % Time of contingency

%% Total r, l, b in pu
% Order: 1    2    3    4    5        6        7
%       1-2, 1-3, 2-3, 2-4, 2-5,     3-4,     4-5
% Mapped from the provided 2-generator 5-bus figure.
r12 = 0.04;
x12 = 0.25;
b12 = 0.50;

r13 = 0.10;
x13 = 0.35;
b13 = 0.00;

r23 = 0.08;
x23 = 0.30;
b23 = 0.50;

% Transformer-equivalent branches
r24 = 0.00;
x24 = 0.015;
b24 = 0.00;

% Unused branches (effectively open)
r25 = 0.00;
x25 = 1e6;
b25 = 0.00;

r34 = 0.00;
x34 = 1e6;
b34 = 0.00;

r45 = 0.00;
x45 = 0.015;
b45 = 0.00;

r = [r12;r13;r23;r24;r25;r34;r45];
x = [x12;x13;x23;x24;x25;x34;x45];
b = [b12;b13;b23;b24;b25;b34;b45];

%% Total R, L, C in Ohm, H, F
R = r*Zn;
L = x*Zn/(2*pi*fn);
C = b/(2*pi*fn*Zn);

%% Compute line lengths in order to achieve a propagation speed around 95% of light speed
T_prop = sqrt(L.*C);
len = ceil(0.95*300000*T_prop);
len(~isfinite(len) | len <= 0) = 1;

%% Zero-sequence parameters
R0 = 3*R;
L0 = 3*L;
C0 = C/3;

%% Load power profiles (in W)
% From figure loads: S1=1.6+j0.8, S2=2+j1, S3=3+j1 on 100 MVA base.
PL1 = 160e6;
QL1 = 80e6;
PL2 = 200e6;
QL2 = 100e6;
PL3 = 300e6;
QL3 = 100e6;

%% Load shedding (in W)
dPLS1 = 0;
dQLS1 = 0;
dPLS2 = 0;
dQLS2 = 0;
dPLS3 = 0;
dQLS3 = 0;
