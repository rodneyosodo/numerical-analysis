import math
import cmath
import numpy as np
from matplotlib import pyplot as plt


class SOLVECCH:
    def __init__(self):
        self.a = None
        self.b = None
        self.c = None
        self.y_o = None
        self.y_prime = None
        self.X = np.linspace(-1 * np.pi, np.pi, 100)

    def get_inputs(self):
        """
        Gets the user inputs for the coefficients and initial conditions
        a: The coefficient a
        b: The coefficient b
        c: The coefficient c
        y_o: Initial condition when y(0) is equal to a value
        y_prime: Initial condition when y'(0) is equal to a value
        """
        self.a = float(input("Enter the value of a: "))
        self.b = float(input("Enter the value of b: "))
        self.c = float(input("Enter the value of c: "))
        self.y_o = float(input("Enter the value of y(0): "))
        self.y_prime = float(input("Enter the value of y`(0): "))

    def plot_solution(self, eq: np.array) -> None:
        """
        Plots the equation in the solution
        :param eq: The characteristic equation
        """
        fig = plt.figure(figsize=(14, 8))
        plt.plot(self.X, eq, 'b', label='Data points')
        plt.legend()
        plt.grid(True, linestyle=':')
        plt.xlim([-6, 6])
        plt.ylim([-4, 4])
        plt.title('CCH')
        plt.xlabel('x-axis')
        plt.ylabel('y-axis')
        plt.show()

    def solve_cch(self) -> bool:
        """
        This function solve the quadratic equations the produces the output equation
        :rtype: bool

        :return: The status of the function
        """
        discriminant = self.b ** 2 - 4 * self.a * self.c
        if discriminant > 0:
            print("The roots are real")
            r1 = (-self.b + math.sqrt((self.b * self.b) - (4 * self.a * self.c))) / (2 * self.a)
            r2 = (-self.b - math.sqrt((self.b * self.b) - (4 * self.a * self.c))) / (2 * self.a)
            A = np.array([[1, 1], [r1, r2]])
            B = np.array([self.y_o, self.y_prime])
            C = np.linalg.solve(A, B)
            eq = round(C[0], 4) * np.exp(r1 * self.X) + round(C[1], 4) * np.exp(r2 * self.X)
            print("Equation is: y = {}e^{}t + {}e^{}t".format(round(C[0], 4), r1, round(C[1], 4), r2))
            self.plot_solution(eq=eq)

        elif discriminant == 0:
            print("The roots are repeated")
            r1 = (-self.b + math.sqrt((self.b * self.b) - (4 * self.a * self.c))) / (2 * self.a)
            eq = round(self.y_o, 4) * np.exp(r1 * self.X) + round((self.y_prime - r1 * self.y_o), 4) * self.X * np.exp(
                r1 * self.X)
            print("Equation is: y = {}e^{}t + {}te^{}t".format(round(self.y_o, 4), r1,
                                                               round((self.y_prime - r1 * self.y_o), 4), r1))
            self.plot_solution(eq=eq)

        elif discriminant < 0:
            print("The roots are imaginary")
            r1 = (-self.b + cmath.sqrt((self.b * self.b) - (4 * self.a * self.c))) / (2 * self.a)
            r2 = (-self.b - cmath.sqrt((self.b * self.b) - (4 * self.a * self.c))) / (2 * self.a)
            A = np.array([[1, 0], [r1.real, r1.imag]])
            B = np.array([self.y_o, self.y_prime])
            C = np.linalg.solve(A, B)
            eq = np.exp(r1.real * self.X) * (
                    round(C[0], 4) * np.cos(r1.imag * self.X) + round(C[1], 4) * np.sin(-1 * r2.imag * self.X))
            print("Equation is: y = e^{}t ({} cos({}t) + {} sin({}t))".format(r1.real, round(C[0], 4), r1.imag,
                                                                              round(C[1], 4), -1 * r2.imag))
            self.plot_solution(eq=eq)

        return True

    def main(self):
        self.get_inputs()
        self.solve_cch()


if __name__ == "__main__":
    my_solve = SOLVECCH()
    my_solve.main()
