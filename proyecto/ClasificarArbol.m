function [clasificaciones] = ClasificarArbol(arbol, atributos, instancias)
% ClasificarArbol   Clasifica la instancia de datos por árbol dado
% args:
%       arbol                - estructura de datos de árbol
%       atributos            - cell array de cadenas de atributos (no CLASS)
%       instancias           - Datos que incluyen clasificación correcta (col. final)
% return:
%       clasificaciones       - 2 números, primero dado por árbol, 2º dado por la última columna de la instancia
% estructura de arbol:
%       valor                 - será la cadena para el atributo de división, o 'verdadero' o 'falso' para la hoja
%       izquierdo             - Puntero izquierdo a otro nodo de árbol (izquierda significa que el atributo de división fue falso)
%       derecho               - Puntero derecho a otro nodo de árbol (derecho significa que el atributo de división fue cierto)

% Almacenar la clasificación actual
actual = instancias(1, length(instancias));

% Recursión con 3 casos.

% Caso 1:El nodo actual tiene etiqueta 'true'
% Trivialmente devolver la clasificación como 1
if (strcmp(arbol.valor, 'true'))
    clasificaciones = [1, actual];
    return
end

% Caso 2: El nodo actual tiene etiqueta 'false'
% Trivialmente devolver la clasificación como 0
if (strcmp(arbol.valor, 'false'));
    clasificaciones = [0, actual];
    return
end

% Caso 3: El nodo actual está etiquetado con un atributo
% Siga la rama correcta mirando el índice en los atributos, y recurre
index = find(ismember(atributos,arbol.valor)==1);
if (instancias(1, index)) % attribute is true for this instance
    % RECURSE EL LADO DERECHO
    clasificaciones = ClasificarArbol(arbol.derecho, atributos, instancias); 
else
    % Volver a bajar el lado izquierdo
    clasificaciones = ClasificarArbol(arbol.izquierdo, atributos, instancias);
end

return
end