syms t n k x(t);

x(t) = input(newline + "Ingresa una función periodica x(t): ")

T_0 = input(newline + "Ingresa el valor del periodo fundamental (T_0) de la función x(t): ")

N = input(newline + "Ingresa el valor de N para truncar la serie de Furier: ")



w_0 = 2*pi/T_0

a(n) = 2/T_0*int(x(t)*cos(n*w_0*t), t, [0 T_0])
b(n) = 2/T_0*int(x(t)*sin(n*w_0*t), t, [0 T_0])

x_n(t) = a(0)/2 + symsum(a(k)*cos(k*w_0*t) + b(k)*sin(k*w_0*t), k, 1, N);



x_n(t)