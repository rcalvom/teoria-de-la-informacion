% Definicion de variables simbolicas.
syms t n k;

% Se recibe la función x(t) por parte del usuario.
x(t) = input(newline + "Ingresa una función periodica x(t): ");

% Se recibe el valor del periodo fundamental T_0.
T_0 = input(newline + "Ingresa el valor del periodo fundamental (T_0) de la función x(t): ");

% Se recibe un vector con todos los limites para truncar las series de Furier.
N = input(newline + "Ingresa un vector con los valores de N para truncar la serie de Furier: ");

% TODO: Graficar x(t)
tiempo=0:0.001:T_0; % Vector de tiempo
Y_x=x(tiempo);      % función evaluada

%Grafica de la función x(t)
tiledlayout(ceil(sqrt(size(N,1))),floor(sqrt(size(N,1)))+1) %tamaño de la cuadricula de graficas
nexttile

%Grafica de x(t)
grafica=plot(tiempo,Y_x, '-', 'LineWidth',2); title(strcat('función X(t) = ',char(x))); xlabel('t'); ylabel(char(x)); hold on; axis([0 T_0 -1.5 1.5 ]);

for i = 1 : size(N, 1);
    x_n(t) = truncated_trigonometric_fourier_series(x, T_0, N(i));  
    Y_xn=x_n(tiempo);      % función x_n evaluada
    %grafica con N_i
    nexttile
    plot(tiempo,Y_x, '-', 'LineWidth',2); title(strcat('function truncated at N = ',string(N(i))));  xlabel('t'); ylabel(char(x)); hold on;
    plot(tiempo,Y_xn, '-', 'LineWidth',2);  legend({'x', 'X_n'},'Location','southwest');legend('boxoff');
    axis([0 T_0 -1.5 1.5 ])
end

% Se informa al usuario que el proceso de graficado a terminado.
disp(newline + "Las gráficas de x(t) y sus respectivas series de Furier x_n(t) han sido generadas.");
