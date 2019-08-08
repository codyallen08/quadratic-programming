% example quadratic programming problem solution
% cody allen 8/8/19

clear
clc
% set options for minimizer: use sequential quadratic programming 
% need optimization toolbox
options = optimoptions('fmincon','Display','iter','Algorithm','sqp');

% define objectiv
fun = @(x) -0.001*x(1)^2 +2*x(1) -0.002*x(2)^2 - 3*x(2) -0.004*x(3)^2 + x(3) + 5;

% initial starting point (make sure this is a feasible point)
x0 = [0.33,0.33,0.33];

% add constraints
% lower and upper bounds
lb = zeros(3,1);  
ub = ones(size(lb)); 

% equality constraint
Aeq = ones(1,3); 
beq = 1;

% minimize
[x,fval,exitflag,output] = fmincon(fun,x0,[],[],Aeq,beq,lb,ub,[],options)

