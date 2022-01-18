% Se leen de consola la lista de simbolos con sus respectivas
% probabilidades
symbol = input('Ingrese los simbolos: ');
prob = input('Ingrese las probabilidades de cada simbolo: ');

% Se comprueba que ambas listas tengan
if length(symbol) ~= length(prob)
   error("El tamaño de ambos arreglos debe ser el mismo.")
end

% Ordenamos las probabilidades y los simbolos con ellas

for i = 1:size(prob, 2)
    for j = 1:size(prob, 2)-1
        if (prob(j) < prob(j + 1))
           aux = prob(j + 1);
           prob(j + 1) = prob(j);
           prob(j) = aux;
           aux_l = symbol(j + 1);
           symbol(j + 1) = symbol(j);
           symbol(j) = aux_l;
        end
    end
end

% Construccion de la matriz de probabilidades
n = size(symbol, 2);
m = zeros(n, n - 1);

% La primera columna corresponde a las probabilidades ordenadas
for i = 1:n
    m(i, 1) = prob(1, i);
end

% En cada iteración se combinan las probabilidades de menor valor y se
% asigna el resultado al final de la siguiente columna. Se ordenan todos
% los valores de la columna de forma descendente.
for col = 2:n-1
    values = zeros(1, n-col+1);
    for row = 1:n-col
        values(1, row) = m(row, col-1);
    end
    values(1, n-col+1) = m(n-col+1, col-1) + m(n-col+2, col-1);
    values = sort(values, 'descend');
    for row = 1:size(values, 2)
        m(row, col) = values(1, row);
    end
end

% Contruccion de los codigos por simbolo
codes = strings(n, n - 1);
codes(1, n - 1) = "0";
codes(2, n - 1) = "1";

for j = n-2:-1:1
    for i = 1:n-j-1
        for k = 1:n-j
            if m(i, j) == m(k, j + 1)
                codes(i, j) = codes(k, j + 1);
                break;
            end
        end
    end
    redu = m(n-j, j) + m(n-j+1, j);
    for k = 1:n-j
        if m(k, j + 1) == redu
            codes(n-j, j) = codes(k, j + 1) + "0";
            codes(n-j+1, j) = codes(k, j + 1) + "1";
        end
    end
end

% Se imprimen las matrices de probabilidades y codigos binarios usadas en
% el algoritmo.
disp('Matriz de probabilidades:');
disp(m);
disp('Matriz de codigos binarios:');
disp(codes);

% Se imprime el codigo resultante para cada simbolo.
disp ('Codigos por simbolo:');
for i = 1:n
    disp(strcat('[', symbol(1, i), '] -> [', codes(i, 1), ']'))
end

% Calculo de la entropia
h_x = 0;
for k = 1:n
    h_x = h_x - prob(k) * log2(prob(k));
end
disp(newline + "H(X) = " + h_x + " b/symbol");

% Calculo de la longitud media por palabra
l = 0;
for k = 1:n
    l = l + prob(k) * strlength(codes(k, 1));
end

disp("L = " + l + " b/symbol");

% Calculo de la eficiencia del codigo
disp("eta = " + h_x / l);