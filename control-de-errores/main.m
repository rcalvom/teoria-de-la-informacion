% Se solicita la matriz de bits de chequeo
P = input("Ingrese la matriz P de los bits de chequeo: ");

% Para cada posible palabra de tamaño k se muestra la respectiva codificación
disp('Palabras de código para cada una de las posibles palabras de datos: ')
words = dec2bin(0: 1 : 2 ^ size(P, 2) - 1) - '0';
for i = 1 : size(words, 1)
    disp(strcat(mat2str(words(i, :)), ' -> ', mat2str(encode(P, words(i, :)))));
end

% Menu para la selección del proceso a realizar
while true;
    disp("Seleccione una opción.");
    disp("1. Codificar una palabra.");
    disp("2. Decodificar a una palabra.");
    option = input("Seleccione una opción: ", 's');
    if option == '1';
        d = input("Ingrese la palabra d a codificar: ");
        r = encode(P, d);
        disp("La palabra " + mat2str(d) + " codificada queda de la siguiente manera: ");
        disp("r = ");
        disp(r)
    elseif option == '2';
        r = input("Ingrese la palabra r a decodificar: ");
        d = decode(P, r);
        disp("La palabra " + mat2str(r) + " decodificada queda de la siguiente manera: ");
        disp("d = ");
        disp(d);
    end
end