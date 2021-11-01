function x_n = truncated_trigonometric_fourier_series(x, T_0, N)
    % La siguiente función implementa las series trigonometricas truncadas de Furier
    % para una señal periodica x(t)
    % Parámetros: función x(t), periodo fundamental t_0,
    % Numero de terminos de la serie de furier N.
    % Resultado: retorna la función x_n(t) con la correspondiente serie de Furier.

    % Se definen variables simbólicas
    syms t n k;

    % Se calcula el valor de la frecuencia Fundamental
    w_0 = 2*pi/T_0;

    % Se calculan los coeficientes de Furier.
    a(n) = piecewise(n == 0, 2/T_0*int(x(t), t, [0 T_0]), n ~= 0, 2/T_0*int(x(t)*cos(n*w_0*t), t, [0 T_0]));
    b(n) = 2/T_0*int(x(t)*sin(n*w_0*t), t, [0 T_0]);

    % Se calcula la serie de Furier teniendo en cuenta los anteriores coeficientes.
    x_n(t) = a(0)/2 + symsum(a(k)*cos(k*w_0*t) + b(k)*sin(k*w_0*t), k, 1, N);
end