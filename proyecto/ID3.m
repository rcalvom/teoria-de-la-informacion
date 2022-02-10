function [arbol] = ID3(ejemplos, atributos, atributosActivos)

% args:
%       ejemplos            - matriz de 1s y 0s para verdaderos y falsos,
%                             siendo el últmo de cada fila el valor del
%                             atributo clasificador
%       atributos           - arreglo de cadenas de atributos (no CLASS)
%
%       atributosActivos    - vector de 1s y 0s, 1 corresponde al 
%                             atributo activo(no CLASS)

% return:
%       arbol                - el nodo raíz de un árbol de decisión 
% estructura de arbol:
%       valor                - será la cadena para el atributo de división,
%                               'true' o 'false' para la hoja.
%       izquierdo            - puntero izquierdo a otro nodo del árbol 
%                              (izquierdo significa que el atributo de división era falso) 
%       derecho               - puntero derecho a otro nodo del árbol 
%                              (derecho significa que el atributo de división era verdadero)

if (isempty(ejemplos))
    error ('Debe proveer ejemplos');
end
disp("etiquetas de atributos")
disp(atributos)
%constantes
numeroAtributos = length(atributosActivos)
numeroEjemplos = length(ejemplos(:,1));

% Creamos el nodo arbol
arbol = struct('valor', 'null', 'izquierdo', 'null', 'derecho', 'null');

% Si el último valor de todas las filas en los ejemplos es 1, devuelva el árbol etiquetado 'verdadero'

sumUltimaCol = sum(ejemplos(:, numeroAtributos + 1 ));

if (sumUltimaCol == numeroEjemplos)
    arbol.valor = 'true';
    return
end

% Si el último valor de todas las filas en los ejemplos es 0, devuelva el árbol etiquetado 'Falso'
if (sumUltimaCol == 0)
    arbol.valor = 'false';
    return
end

% Si atributosActivos está vacío, devuelve el árbol con la etiqueta con el valor más común
if (sum(atributosActivos) == 0)
    if (sumUltimaCol >= numeroEjemplos / 2)
        arbol.valor = 'true';
    else
        arbol.valor = 'false';
    end
    return
end

% Encontramos la entropia actual
p1 = sumUltimaCol / numeroEjemplos;
if (p1 == 0);
    p1_eq = 0;
else
    p1_eq = -1*p1*log2(p1);
end
p0 = (numeroEjemplos - sumUltimaCol) / numeroEjemplos;
if (p0 == 0);
    p0_eq = 0;
else
    p0_eq = -1*p0*log2(p0);
end
entropiaActual = p1_eq + p0_eq;

% Encuentra el atributo que maximiza la ganancia de la información.

ganancia = -1*ones(1,numeroAtributos); %-1 si está inactivo, ganancias para todos los demás bucles
                                       %a través de los atributos que actualizan las ganancias, asegurándose de que todavía estén activos
                                       
for i=1:numeroAtributos
    if (atributosActivos(i)) % Este sigue activo, actualiza su ganancia.
        s0 = 0; s0_and_true = 0;
        s1 = 0; s1_and_true = 0;
        for j=1:numeroEjemplos
            if (ejemplos(j,i)) % Esta instancia ha dividido el Atr. true
                s1 = s1 + 1;
                if (ejemplos(j, numeroAtributos + 1)) %atr. objetivo es true
                    s1_and_true = s1_and_true + 1;
                end
            else
                s0 = s0 + 1;
                if (ejemplos(j, numeroAtributos + 1 )) %atr. objeivo es true
                    s0_and_true = s0_and_true + 1;
                end
            end
        end
        
        % Entropia para S(v=1)
        if (~s1)
            p1 = 0;
        else
            p1 = (s1_and_true / s1); 
        end
        if (p1 == 0)
            p1_eq = 0;
        else
            p1_eq = -1*(p1)*log2(p1);
        end
        if (~s1)
            p0 = 0;
        else
            p0 = ((s1 - s1_and_true) / s1);
        end
        if (p0 == 0)
            p0_eq = 0;
        else
            p0_eq = -1*(p0)*log2(p0);
        end
        entropy_s1 = p1_eq + p0_eq;

        % Entropia para S(v=0)
        if (~s0)
            p1 = 0;
        else
            p1 = (s0_and_true / s0); 
        end
        if (p1 == 0)
            p1_eq = 0;
        else
            p1_eq = -1*(p1)*log2(p1);
        end
        if (~s0)
            p0 = 0;
        else
            p0 = ((s0 - s0_and_true) / s0);
        end
        if (p0 == 0)
            p0_eq = 0;
        else
            p0_eq = -1*(p0)*log2(p0);
        end
        entropy_s0 = p1_eq + p0_eq;
        
        ganancia(i) = entropiaActual - ((s1/numeroEjemplos)*entropy_s1) - ((s0/numeroEjemplos)*entropy_s0);
    end
end
disp("ganancia")
disp(ganancia)
% Elige el atributo que maximiza las ganancias.
[~, bestAttribute] = max(ganancia);

% Establecemos arbol.valor a la cadena relevante de bestattribute
arbol.valor = atributos(bestAttribute);

% Retirar el atributo de división de atributosActivos
atributosActivos(bestAttribute) = 0;

% Inicialice y cree las nuevas matrices de ejemplo.
ejemplos_0 = []; ejemplos_0_index = 1;
ejemplos_1 = []; ejemplos_1_index = 1;
for i=1:numeroEjemplos
    if (ejemplos(i, bestAttribute)) % Esta instancia lo tiene como 1/true
        ejemplos_1(ejemplos_1_index, :) = ejemplos(i, :); % copiar
        ejemplos_1_index = ejemplos_1_index + 1;
    else
        ejemplos_0(ejemplos_0_index, :) = ejemplos(i, :);
        ejemplos_0_index = ejemplos_0_index + 1;
    end
end

% Para ambos valores del atributo de división.
% Para valor = falso o 0, corresponde a la rama izquierda
% Si Ejemplos_0 está vacío, agregue nodo de hoja a la izquierda con la
% etiqueta necesaria
if (isempty(ejemplos_0))
    hoja = struct('valor', 'null', 'izquierdo', 'null', 'derecho', 'null');
    if (sumUltimaCol >= numeroEjemplos / 2) % para la matri ejemplos
        hoja.valor = 'true';
    else
        hoja.valor = 'false';
    end
    arbol.izquierdo = hoja;
else
    % Aquí  usamos recursión .
    arbol.izquierdo = ID3(ejemplos_0, atributos, atributosActivos);
end

% Para valor = verdadero o 1, corresponde a la rama derecha
% Si los ejemplos_1 está vacío, agregue un nodo de hoja a la derecha con la etiqueta relevante
if (isempty(ejemplos_1))
    hoja = struct('valor', 'null', 'izquierdo', 'null', 'derecho', 'null');
    if (sumUltimaCol >= numeroEjemplos / 2) % para la matriz ejempos
        hoja.valor = 'true';
    else
        hoja.valor = 'false';
    end
    arbol.derecho = hoja;
else
    % Aquí usamos recursion
    arbol.derecho = ID3(ejemplos_1, atributos, atributosActivos);
end

% retornamos el arbol
return
end