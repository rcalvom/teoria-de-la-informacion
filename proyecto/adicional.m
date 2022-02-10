[name, path] = uigetfile('*.csv', 'Indica el archivo con los datos a procesar');


if name ~= 0
    data = strcat(path, name);
    table = readtable(data);
    activos = ones(1,width(table)-1);
    arreglo = table2array(table)
    atributos = table.Properties.VariableNames;
    arbol = ID3(arreglo,atributos,activos)
    disp("inicio")
    imprimirArbol(arbol, 'root');
end
            
   