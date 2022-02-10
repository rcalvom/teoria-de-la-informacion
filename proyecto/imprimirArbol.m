function [] = imprimirArbol(arbol, padre)
% Prints the tree structure (preorder traversal)
fprintf('Inicio');
% Print current node
if (strcmp(arbol.valor, 'true'))
    fprintf('padre: %s\ttrue\n', padre);
    return
elseif (strcmp(arbol.valor, 'false'))
    fprintf('padre: %s\tfalse\n', padre);
    return
else
    % Nodo actual Un divisor de atributos
    fprintf('padre: %s\tatributo: %s\tfalseChild:%s\ttrueChild:%s\n', ...
        padre, string(arbol.valor(1)), string(arbol.izquierdo.valor(1)),string(arbol.derecho.valor(1)));
end

% Recuperar el subárbol izquierdo
imprimirArbol(arbol.izquierdo, string(arbol.valor));

% Recurre el subárbol derecho
imprimirArbol(arbol.derecho, string(arbol.valor));

end