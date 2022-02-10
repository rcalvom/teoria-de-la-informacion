% ID3 Algoritmo de árbol de decisión

function[] = arbolDecision(nombreArchivo, tamanoEntrenamiento, numeroIntentos,...
                          info)
% arbolDecision crea un arbol de decision usando el algoritmo ID3
% args:
%   nombreArchivo           - la ruta completamente especificada al archivo de entrada
%   tamanoEntrenamiento     - Entero que especifica el número de ejemplos de la entrada 
%                             utilizada para entrenar el conjunto de datos

%   numeroIntentos          - Entero que especifica cuántas veces el árbol de decisión se construirá 
%                             a partir de un subconjunto seleccionado al
%                             azar de los ejemplos de entrenamiento
%   info                    - Cadena que debe ser entre '1' o '0', si la salida es '1' incluye conjuntos de capacitación y pruebas, 
%                             de lo contrario, solo contendrá la descripción del árbol y los resultados para los ensayos.

% Leer en el archivo de texto especificado que contiene los ejemplos
archivoEjemplos = fopen(nombreArchivo, 'rt');
datosEntrada = textscan(archivoEjemplos, '%s');

% Cerramos el archivo
fclose(archivoEjemplos);

% Reformateamos los datos en la matriz de atributos y la matriz de datos de 1s y 0s para
% true o false
i = 1;
% Primero almacenamos los atributos en una matriz .
while (~strcmp(datosEntrada{1}{i}, 'CLASS'))
    i = i + 1;
end
atributos = cell(1,i);
for j=1:i
    atributos{j} = datosEntrada{1}{j};
end

% NOTA: La clasificación será el atributo final en las filas de datos a continuación.
numeroAtributos = i;
numeroInstancias = (length(datosEntrada{1}) - numeroAtributos) / numeroAtributos;
% Luego almacene los datos en la matriz
datos = zeros(numeroInstancias, numeroAtributos);
i = i + 1;
for j=1:numeroInstancias
    for k=1:numeroAtributos
        datos(j, k) = strcmp(datosEntrada{1}{i}, 'true');
        i = i + 1;
    end
end

% Aquí es donde comienzan los ensayos.
for i=1:numeroIntentos;
    
    % Imprime el número de prueba
    fprintf('Número de prueba: %d\n\n', i);
    
    % Dividir datos en los conjuntos de entrenamiento y prueba al azar
    % Usamos RandSample para obtener un vector de números de fila para el conjunto de entrenamiento
    filas = sort(randsample(numeroInstancias, tamanoEntrenamiento));
    % Inicialice dos nuevas matrices, conjunto de entrenamiento y conjunto de pruebas
    conjuntoEntrenamiento = zeros(tamanoEntrenamiento, numeroAtributos);
    tamanoConjuntoPruebas = (numeroInstancias - tamanoEntrenamiento);
    conjuntoPruebas = zeros(tamanoConjuntoPruebas, numeroAtributos);
    % Bucle a través de la matriz de datos, copiando filas relevantes a cada matriz
    entranamiento_index = 1;
    pruebas_index = 1;
    for datos_index=1:numeroInstancias;
        if (filas(entranamiento_index) == datos_index);
            conjuntoEntrenamiento(entranamiento_index, :) = datos(datos_index, :);
            if (entranamiento_index < tamanoEntrenamiento);
                entranamiento_index = entranamiento_index + 1;
            end
        else
            conjuntoPruebas(pruebas_index, :) = datos(datos_index, :);
            if (pruebas_index < tamanoConjuntoPruebas);
                pruebas_index = pruebas_index + 1;
            end
        end
    end
    
    % Si info, imprime el conjunto de entrenamiento
    if (info)
        for ii=1:numeroAtributos
            fprintf('%s\t', atributos{ii});
        end
        fprintf('\n');
        for ii=1:tamanoEntrenamiento;
            for jj=1:numeroAtributos;
                if (conjuntoEntrenamiento(ii, jj));
                    fprintf('%s\t', 'true');
                else
                    fprintf('%s\t', 'false');
                end
            end
            fprintf('\n');
        end
    end
    
    % Estimar la probabilidad previa esperada de verdadero y falso basado
    % en el conjunto de entrenamiento
    if (sum(conjuntoEntrenamiento(:, numeroAtributos)) >= tamanoEntrenamiento)
        esperado = 'true';
    else
        esperado = 'false';
    end
    
    % Construir un árbol de decisión en el conjunto de entrenamiento utilizando el algoritmo ID3
    atributosActivos = ones(1, length(atributos) - 1);
    nuevos_atributos = atributos(1:length(atributos)-1);
    disp("Conjunto de datos entrenados")
    disp(conjuntoEntrenamiento)
    arbol = ID3(conjuntoEntrenamiento, atributos, atributosActivos);
    
    % Print out the tree
    fprintf('Estructura de los árboles de decisión:\n');
    imprimirArbol(arbol, 'root');
    
    % Ejecutar árboles y esperado antes de la prueba establecida, registrando clasificaciones
    % La segunda columna es para la clasificación real, primero para calcular
    ID3_Clasificaciones = zeros(tamanoConjuntoPruebas,2);
    Esperanza_Clasificaciones = zeros(tamanoConjuntoPruebas,2);
    ID3_numCorrect = 0; Esperanza_numCorrect = 0;
    for k=1:tamanoConjuntoPruebas %sobre el conjunto de pruebas
        % Llame a una función recursiva para seguir los nodos de los árboles y clasificar
        ID3_Clasificaciones(k,:) = ...
            ClasificarArbol(arbol, nuevos_atributos, conjuntoPruebas(k,:));
        
        Esperanza_Clasificaciones(k, 2) = conjuntoPruebas(k,numeroAtributos);
        if (esperado)
            Esperanza_Clasificaciones(k, 1) = 1;
        else
            Esperanza_Clasificaciones(k, 0) = 0;
        end
        
        if (ID3_Clasificaciones(k,1) == ID3_Clasificaciones(k, 2)); %correcto
            ID3_numCorrect = ID3_numCorrect + 1;
        end
        if (Esperanza_Clasificaciones(k,1) == Esperanza_Clasificaciones(k,2));
            Esperanza_numCorrect = Esperanza_numCorrect + 1;
        end     
    end
    
    % Si info, imprima los datos de prueba con la clase Final Dos columnas ID3 y la clase anterior
    if (info);
        for ii=1:numeroAtributos;
            fprintf('%s\t', atributos{ii});
        end
        fprintf('%s\t%s\t', 'ID3 Class', 'Clase previa');
        fprintf('\n');
        for ii=1:tamanoConjuntoPruebas;
            for jj=1:numeroAtributos;
                if (conjuntoPruebas(ii, jj));
                    fprintf('%s\t', 'true');
                else
                    fprintf('%s\t', 'false');
                end
            end
            if (ID3_Clasificaciones(ii,1));
                fprintf('%s\t', 'true');
            else
                fprintf('%s\t', 'false');
            end
            if (Esperanza_Clasificaciones(ii,1));
                fprintf('%s\t', 'true');
            else
                fprintf('%s\t', 'false');
            end
            fprintf('\n');
        end
    end
    
    % Calcular las proporciones correctas e imprimir
    if (tamanoConjuntoPruebas);
        ID3_porcentaje = round(100 * ID3_numCorrect / tamanoConjuntoPruebas);
        porcentajeEsperado = round(100 * Esperanza_numCorrect / tamanoConjuntoPruebas);
    else
        ID3_porcentaje = 0;
        porcentajeEsperado = 0;
    end
    ID3_porcentajes(i) = ID3_porcentaje;
    porcentajesEsperados(i) = porcentajeEsperado;
    
    fprintf('\tPorcentaje de casos de prueba correctamente clasificados por un árbol de decisión ID3 = %d\n' ...
        , ID3_porcentaje);
    fprintf('\tPorcentaje de casos de prueba correctamente clasificados mediante el uso de probabilidades previas del conjunto de entrenamiento = %d\n\n' ...
        , porcentajeEsperado);
end
 
 mediaID3 = round(mean(ID3_porcentajes));
 mediaAnterior = round(mean(porcentajesEsperados));
 
 % Print out remaining details
 fprintf('Ejemplo de archivo utilizado = %s\n', nombreArchivo);
 fprintf('Número de ensayos = %d\n', numeroIntentos);
 fprintf('Tamaño del conjunto de entrenamiento para cada prueba = %d\n', tamanoEntrenamiento);
 fprintf('Tamaño de prueba de prueba para cada prueba = %d\n', tamanoConjuntoPruebas);
 fprintf('Rendimiento medio (porcentaje correcto) del árbol de decisión sobre todos los ensayos = %d\n', mediaID3);
 fprintf('Rendimiento medio (porcentaje correcto) de probabilidad previa del conjunto de entrenamiento = %d\n\n', mediaAnterior);
 
 
 disp(arbol.izquierdo.izquierdo)
 disp(arbol.derecho.izquierdo)
end