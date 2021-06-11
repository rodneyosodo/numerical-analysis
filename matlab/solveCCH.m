% Aurthor:  Rodney Osodo
% Course:   Bsc. Mechatronic Enhineering

function solveCCH
    % main function
    [a, b, c, y_o, y_prime] = get_inputs();
    equation1 = solve_cch(a, b, c, y_o, y_prime);
    equation2 = solveEquationWithDSolve(a,b,c, y_o, y_prime);
    ez1 = ezplot(str2sym(equation1) ,[-2 * pi,2 * pi]);
    hold on;
    ez2 = ezplot(equation2, [-2 * pi, 2 * pi]);
end

function eq = solve_cch(a, b, c, y_o, y_prime)
    discriminant = b .* b - 4  .*  a  .*  c;
    if (discriminant > 0)
        % 0.8*exp(3*t) + 0.2*exp(-2*t)
        fprintf("The roots are real\n");
        r1 = (-b + sqrt((b .* b) - (4 .* a .* c))) ./ (2 .* a);
        r2 = (-b - sqrt((b .* b) - (4 .* a .* c))) ./ (2 .* a);
        A = [1 1;r1 r2];
        B = [y_o; y_prime];
        C = linsolve(A,B);
        eq = string(C(1)) + "*exp(" + string(r1) + "*t)" + " + " + string(C(2)) + "*exp(" + string(r2) + "*t)";
        disp(eq);
    elseif (discriminant == 0)
        % 12*exp(2*t)+-27*t*exp(2*t)
        fprintf("The roots are repeated\n");
        r1 = (-b + sqrt((b .* b) - (4 .* a .* c))) ./ (2 .* a);
        eq = string(round(y_o, 4)) + "*exp(" + string(r1) + "*t)" + "+" + string(round((y_prime - r1 .* y_o), 4)) + "*t*exp(" + string(r1) + "*t)";
        disp(eq);
    elseif (discriminant < 0)
        % 1*cos(2*t)*exp(5*t) - 1*sin(2*t)*exp(5*t)
        fprintf("The roots are imaginary\n");
        r1 = (-b + sqrt((b .* b) - (4 .* a .* c))) ./ (2 .* a);
        r2 = (-b - sqrt((b .* b) - (4 .* a .* c))) ./ (2 .* a);
        A = [1 0;real(r1) imag(r1)];
        B = [y_o; y_prime];
        C = linsolve(A,B);
        eq = string(round(C(1), 4)) + "*cos(" + string(imag(r1)) + "*t)" + "*exp(" + string(real(r1)) + "*t)" + " - " + string(round(C(1), 4)) + "*sin(" + string(-1  .*  imag(r2)) + "*t)" + "*exp(" + string(real(r1)) + "*t)";
        disp(eq);
    end
end

function dSolveSolution = solveEquationWithDSolve(a, b, c, y1, y2)
    % solves using dsolve
    syms y(t)
    Dy = diff(y, t);
    ode_eqn = a * diff(y, t, 2) + b * diff(y, t) + c * y == 0;
    cond = [y(0) == y1, Dy(0) == y2];
    dSolveSolution = dsolve(ode_eqn, cond);
    disp('DSolve Solution');
    disp(dSolveSolution);
end

function [a, b, c, y_o, y_prime] = get_inputs()
    % gets user input
    syms a b c y(t) dy(t)
    genericEqn = a*diff(y,2) + b *diff(y) + c*y == 0;
    disp("Enter an equation of the form:");
    disp(genericEqn);
    a = input('Enter the value of a: ');
    b = input('Enter the value of b: ');
    c = input('Enter the value of c: ');
    y_o = input('Enter the value of y(0): ');
    y_prime = input('Enter the value of y`(0): ');
end