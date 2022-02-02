function d = decode(P, r);
    Ht = [P'; eye(size(P, 1))];
    s = r * Ht;
    for i = 1 : size(s, 2);
        s(i) = mod(s(i), 2);
    end
    error = false;
    for i = 1 : size(Ht, 1);
        if isequal(s, Ht(i, :));
            disp("Se ha encontrado una incosistencia en el bit " + i + " de la palabra dada. Se ha corregido dicha inconsistencia");
            error = true;
            r(i) = mod((r(i) + 1), 2);
            break;
        end
    end
    if ~error;
        disp("No se encontró ninguna inconsistencia en la palabra dada.");
    end
    d = r(1 : 3);
end