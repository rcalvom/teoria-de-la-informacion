function d = decode(P, r);
% decode - Decodifica una palabra de bits r usando una matriz
% de bits de chequeo P
% P - Matriz de bits de chequeo
% r - Palabra de bits a decodificar

    % Se calcula Ht usando la traspuesta de P
    Ht = [P'; eye(size(P, 1))];
    % Se calcula s como el producto de r y Ht
    s = r * Ht;
    % Se obtiene el mod 2 por cada posicion del vector s
    for i = 1 : size(s, 2);
        s(i) = mod(s(i), 2);
    end
    error = false;
    % Se itera por cada fila de la matriz Ht
    for i = 1 : size(Ht, 1);
        % Si el vector s es igual a alguna fila de la matriz Ht
        if isequal(s, Ht(i, :));
            disp("Se ha encontrado una incosistencia en el bit " + i + " de la palabra dada. Se ha corregido dicha inconsistencia.");
            error = true;
            % Se corrige el error detectado
            r(i) = mod((r(i) + 1), 2);
            break;
        end
    end
    if ~error;
        disp("No se encontró ninguna inconsistencia en la palabra dada.");
    end
    % Se guardan unicamente los 3 primeros bits del vector r como la palabra decodificada
    d = r(1 : 3);
end