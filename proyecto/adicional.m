[name, path] = uigetfile('*.csv', 'Indica el archivo con los datos a procesar');


if name ~= 0
    data = strcat(path, name);
    table = readtable(data);
    atributos = ones(1,width(table));
    arreglo = table2array(table)
    arbol = ID3(arreglo,arreglo(:,size(arreglo,2)),atributos)
    disp("inicio")
    %imprimirArbol(arbol, 'root');
end
            
   