function r = encode(P, d)
% encode - Codifica una palabra de bits d usando una matriz
% de bits de chequeo P
% P - Matriz de bits de chequeo
% d - Palabra de bits a codificar

    % Se obtiene la matriz G usando la Matriz P
    G = [eye(size(P, 1)) P'];
    % Se calcula r como el producto de d y G
    r = d * G;
    % Se obtiene el mod 2 de cada componente en el vector r
    for i = 1 : size(r, 2);
        r(i) = mod(r(i), 2);
    end
end
