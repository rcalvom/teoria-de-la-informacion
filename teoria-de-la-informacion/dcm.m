% Se solicita al usuario el valor de [P(X)]
P_x = input('Ingrese la matriz de probabilidades de entrada [P(X)]: ');

% Se solicita al usuario el valor de [P(Y|X)]
P_yx = input('Ingrese la matriz de matriz del canal [P(Y|X)]: ');

% Se calcula el valor de [P(Y)] = [P(X)][P(Y|X)]
P_y = P_x * P_yx;

% Se representa [P(X)] como una matriz diagonal [P(X)]d
P_xd = diag(P_x);

% Se calcula [P(X,Y)] = [P(X)]d[P(Y|X)]
P_xy = P_xd * P_yx;

% Ahora se calcula H(X)= -Suma(P(X_i)log2(P(X_i)))
H_x = 0;
N = size(P_x, 2);
for k = 1 : N
    if P_x(k) ~= 0;
        H_x = H_x - P_x(k) * log2(P_x(k));
    end    
end

% Se calcula H(Y) = -Suma(P(Y_j)log2(P(Y_j)))
H_y = 0;
N = size(P_y, 2);
for k= 1 : N;
    if P_y(k) ~= 0;
        H_y = H_y - P_y(k) * log2(P_y(k));
    end
end

% Se calcula H(Y|X) = -Suma(Suma(P(x_i, y_j)log2(P(Y_i|X_j))))
H_yx = 0;
for i = 1 : size(P_xy, 2);
    for j=1:size(P_yx, 2);
        if P_yx(i, j) ~= 0;
            H_yx = H_yx - P_xy(i, j) * log2(P_yx(i, j));
        end
    end
end

% Se calcula H(X|Y) = -Suma(Suma(P(x_i, y_j)log2(P(X_i|Y_j))))
H_xy = 0;
for i = 1 : size(P_xy, 2)
    for j = 1 : size(P_xy, 2)
        if P_xy(i, j) ~= 0
            H_xy = H_xy - P_xy(i, j) * log2(P_xy(i, j));
        end
    end
end

% Se calcula I(X; Y) = H(Y) - H(Y|X)
I_xy = H_y - H_yx;

disp("Los valorse de las matrices son los siguientes: ");
disp("[P(Y)]: ");
disp(P_y);
disp("[P(X,Y)]: ");
disp(P_xy);
disp("H(X): ");
disp(H_x);
disp("H(Y|X): ");
disp(H_yx);
disp("H(Y): ");
disp(H_y);
disp("H(X|Y): ");
disp(H_xy)
disp("I(X;Y): ");
disp(I_xy);

% Se calcula Cs = 1 + p log2(p) + (1-p) log2(1 - p)
C_s = I_xy;

% Se comprueba si es canal simetrico
if (P_yx(2, 1) == P_yx(1, 2));
    % Se define el valor de p
    P = P_yx(2, 1);
    % Comprobamos los otros dos valores de la matriz [P(Y|X)]
    if(P_yx(1, 1) == 1 - P && P_yx(2, 2) == 1 - P);
        if (1 - P) ~= 0;
            C_s = 1 + P * log2(P) + (1 - P) * log2(1 - P);
            disp("C_s:");
            disp(C_s);
        end
    end
end



