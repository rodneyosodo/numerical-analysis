function solveCCH
    [a, b, c, y_o, y_prime] = get_inputs();
    solve_quadratic(a, b, c, y_o, y_prime);
end

function solve_quadratic(a, b, c, y_o, y_prime)
    discriminant = b .* b - 4  .*  a  .*  c;
    if (discriminant > 0)
        fprintf("The roots are real\n");
        r1 = (-b + sqrt((b .* b) - (4 .* a .* c))) ./ (2 .* a);
        r2 = (-b - sqrt((b .* b) - (4 .* a .* c))) ./ (2 .* a);
        A = [1 1;r1 r2];
        B = [y_o; y_prime];
        C = linsolve(A,B);
        fprintf("Equation is: y = %fe^%ft + %fe^%ft\n", round(C(1), 4), r1, round(C(1), 4), r2);
    elseif (discriminant == 0)
        fprintf("The roots are repeated\n");
        r1 = (-b + sqrt((b .* b) - (4 .* a .* c))) ./ (2 .* a);
        fprintf("Equation is: y = %fe^%ft + %fte^%ft\n", round(y_o, 4), r1, round((y_prime - r1 .* y_o), 4), r1);
    elseif (discriminant < 0)
        fprintf("The roots are imaginary\n");
        r1 = (-b + sqrt((b .* b) - (4 .* a .* c))) ./ (2 .* a);
        r2 = (-b - sqrt((b .* b) - (4 .* a .* c))) ./ (2 .* a);
        A = [1 0;real(r1) imag(r1)];
        B = [y_o; y_prime];
        C = linsolve(A,B);
        fprintf("Equation is: y = e^%ft (%f cos(%ft) + %f sin(%ft))\n", real(r1), round(C(1), 4), imag(r1), round(C(1), 4), -1  .*  imag(r2));
    end
end

function [a, b, c, y_o, y_prime] = get_inputs()
    a = input('Enter the value of a: ');
    b = input('Enter the value of b: ');
    c = input('Enter the value of c: ');
    y_o = input('Enter the value of y(0): ');
    y_prime = input('Enter the value of y`(0): ');
end