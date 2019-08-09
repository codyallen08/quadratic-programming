% example power station optimization
clear
clc
close all
options = sdpsettings('solver', 'sedumi', 'sedumi.eps', 0, ...
                'sedumi.bigeps',1e-10,'sedumi.cg.restol',1e-5,...
                'sedumi.cg.qprec', 1, 'sedumi.cg.maxiter', 1000, ...
                'sedumi.cg.refine',5,...
                'sedumi.stepdif', 2,'verbose',1);
            
            
% initial values            
total_load = 347; % total load on GTs
max_peak = 472.5; % for spinning reserve
g1max = 100;
g2max = 120;
g3max = 160;
g4max = 200;

% power to cost curves 
%g1 = 200 + 15*p1 + 0.2*p1^2;
%g2 = 300 + 17*p2 + 0.1*p2^2;
%g3 = 150 + 12*p3 + 0.15*p3^2;
%g4 = 500 + 2*p4 + 0.07*p4^2;

A = [sqrt(0.2) 0 0 0; 0 sqrt(0.1) 0 0; 0 0 sqrt(0.15) 0; 0 0 0 sqrt(0.07)];
b = [15; 17; 12; 2];
cons = 200+300+150+500;

I = eye(4);
max_pow = [g1max; g2max; g3max; g4max];
d = [1; 1; 1; 1];

% minimization problem (x = power)
clear x
x = sdpvar(4, 1);

% define constraints (spinning reserve must be checked at end for truth
% value)
Constraints = [I*x<=max_pow, d'*x == total_load, x>= 0];
Objective = (x'*(A'*A)*x + b'*x + cons); % this is squared 2 norm

% solve optimization
yal_sol = optimize(Constraints,Objective,options);

% capture results
xx = value(x);

% display results
disp(sprintf('\n\n'))
disp(sprintf('Final Solution:\npow1 = %f\npow2 = %f\npow3 = %f\npow4 = %f',xx))
% spinning reserve check
disp(sprintf('spinning reserve: %iMW',round(sum(max_pow - xx))))

% repeat