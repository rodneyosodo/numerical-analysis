import math
import cmath
import numpy as np

def get_inputs():
    a = float(input("Enter the value of a: "))
    b = float(input("Enter the value of b: "))
    c = float(input("Enter the value of c: "))
    y_o = float(input("Enter the value of y(0): "))
    y_prime = float(input("Enter the value of y`(0): "))
    return a, b, c, y_o, y_prime

def solve_quadratic(a, b, c, y_o, y_prime):
    discriminant = b**2 - 4 * a * c
    if discriminant > 0:
        print("The roots are real")
        r1 = (-b + math.sqrt((b*b) - (4*a*c)))/(2*a)
        r2 = (-b - math.sqrt((b*b) - (4*a*c)))/(2*a)
        print("Equation is: y = c1e^{}t + c2e^{}t".format(r1, r2))
        A = np.array([[1, 1],[r1, r2]])
        B = np.array([y_o, y_prime])
        C = np.linalg.solve(A,B)
        print("Equation is: y = {}e^{}t + {}e^{}t".format(round(C[0], 4), r1, round(C[1], 4), r2))

    elif discriminant == 0:
        print("The roots are repeated")
        r1 = (-b + math.sqrt((b*b) - (4*a*c)))/(2*a)
        print("Equation is: y = {}e^{}t + {}te^{}t".format(round(y_o, 4), r1, round((y_prime - r1*y_o), 4), r1))
    elif discriminant < 0:
        print("The roots are imaginary")
        r1 = (-b + cmath.sqrt((b*b) - (4*a*c)))/(2*a)
        r2 = (-b - cmath.sqrt((b*b) - (4*a*c)))/(2*a)
        A = np.array([[1, 0],[r1.real, r1.imag]])
        B = np.array([y_o, y_prime])
        C = np.linalg.solve(A,B)
        print("Equation is: y = e^{}t ({} cos({}t) + {} sin({}t))".format(r1.real, round(C[0], 4), r1.imag, round(C[1], 4), -1 * r2.imag))

    return True
    
def main():
    a, b, c, y_o, y_prime = get_inputs()
    print(solve_quadratic(a, b, c, y_o, y_prime))

if __name__ == "__main__":
    main()

