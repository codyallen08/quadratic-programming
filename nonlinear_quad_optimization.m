clear
clc

options = optimoptions('fmincon','Display','iter','Algorithm','sqp');

fun = @(x) -0.001*x(1)^2 +2*x(1) -0.002*x(2)^2 - 3*x(2) -0.004*x(3)^2 + x(3) + 5;
x0 = [0.33,0.33,0.33];
lb = zeros(3,1);
ub = ones(size(lb));
Aeq = ones(1,3);
beq = 1;

[x,fval,exitflag,output] = fmincon(fun,x0,[],[],Aeq,beq,lb,ub,[],options)
xx = [0;1;0];

fun(x)
