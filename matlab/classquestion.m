% Aurthor:  Rodney Osodo
% Course:   Bsc. Mechatronic Enhineering

function solveCCH
    % main function
    [a, b] = get_inputs();
    equation1 = solve_cch(a, b);
    equation2 = solveEquationWithDSolve(a,b);
    ez1 = ezplot(str2sym(equation1) ,[-0.5 ,0.5]);
    hold on;
    ez2 = ezplot(equation2, [-0.5 , 0.5]);
end

function eq = solve_cch(a, b, c)
    eq = "C1*exp(" + string(-1*b) + "*t)";
    disp(eq);
end

function dSolveSolution = solveEquationWithDSolve(a, b)
    % solves using dsolve
    syms y(t)
    Dy = diff(y, t);
    ode_eqn = a * diff(y, t) + b * y == 0;
    dSolveSolution = dsolve(ode_eqn);
    disp('DSolve Solution');
    disp(dSolveSolution);
end

function [a, b] = get_inputs()
    % gets user input
    a = input('Enter the value of a: ');
    b = input('Enter the value of b: ');
end