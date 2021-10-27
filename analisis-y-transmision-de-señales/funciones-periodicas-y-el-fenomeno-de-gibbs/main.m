syms t, n;

x = inline(input(newline + "Ingresa una función periodica x(t): "))

T_0 = input(newline + "Ingresa el valor del periodo fundamental (T_0) de la función x(t): ")

N = input(newline + "Ingresa el valor de N para truncar la serie de Furier: ")



w_0 = 2*pi/T_0

a(n) = 2/T_0*int(x(t)*cos(n*w_0*t), t, [0 T_0])
b(n) = 2/T_0*int(x(t)*sin(n*w_0*t), t, [0 T_0])

x_n(t) = a(0)/2;


for k = 1 : N;
    r = x_n(t) + a(k)*cos(k*w_0*t) + b(k)*sin(k*w_0*t)
end

x_n(t)