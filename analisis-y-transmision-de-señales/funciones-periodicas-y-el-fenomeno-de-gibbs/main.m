% Definicion de variables simbolicas.
syms t n k;

% Se recibe la función x(t) por parte del usuario.
x(t) = input(newline + "Ingresa una función periodica x(t): ");

% Se recibe el valor del periodo fundamental T_0.
T_0 = input(newline + "Ingresa el valor del periodo fundamental (T_0) de la función x(t): ");

% Se recibe un vector con todos los limites para truncar las series de Furier.
N = input(newline + "Ingresa un vector con los valores de N para truncar la serie de Furier: ");

% TODO: Graficar x(t)
for i = 1 : size(N, 1);
    x_n(t) = truncated_trigonometric_fourier_series(x, T_0, N(i));    
end

% Se informa al usuario que el proceso de graficado a terminado.
disp(newline + "Las gráficas de x(t) y sus respectivas series de Furier x_n(t) han sido generadas.");