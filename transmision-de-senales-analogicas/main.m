%%% A. MUESTREO %%%

% Se ingresa el valor del la señal de mensaje m(t).
m = str2func(strcat('@(t)', input("Ingrese el valor de la señal m(t): ", 's')));

% Se ingresa el valor de la frecuencia f.
f_m = input("Ingrese la frecuencia f de la señal: ");

% Se ingresa el valor del periodo de muestreo T_s.
T_s = input("Ingrese el valor del periodo de muestreo T_s: ");

% Se crea el vector t.
t = 0 : 0.01 : f_m;

% Se encuentra el valor máximo de m para usarlo en los limites de la gráfica.
max_mt = double(max(m(t)));

% Se grafica m(t)
subplot(4, 1, 1);
plot(t, m(t), "-"); xlabel("t"); ylabel("m(t)"); title("Gráfica de la señal m(t)");  axis([0 f_m -(max_mt + 0.5) (max_mt + 0.5)]);

% Se calcula el vector t_n.
t_n = 0 : T_s : f_m;

% Se grafican las muestras de la señal m(t)
subplot(4, 1, 2);
stem(t_n, m(t_n));
xlabel("t_n"); ylabel("m(t_n)"); title("Gráfica de las muestras de la señal m(t)"); axis([0 f_m -(max_mt + 0.5) (max_mt + 0.5)]);


%%% B. Cuantización %%%


% Se ingresa la cantidad de bits a codificar
n = input("Ingrese el numero de bits (n) a codificar: ");

% Se cuantiza la señal usando el script dado en clase.
xq = cuantUniforme(m(t_n), 1, n);

subplot(4, 1, 3);
plot(t_n, xq, 'k');
xlabel('nT_s'); ylabel('x_q(nT_s)'); title("Gráfica de la señal m(t) cuantizada");
axis([0 f_m -(max_mt + 0.5) (max_mt + 0.5)]); xlabel('nT_s'); ylabel('x_q(nT_s)');


%%% C. CODIFICACIÓN %%%

level = unique(sort(xq));
train = "";
cod = "";
arr = [];
for i = 1 : length(xq)
    k = find(level == xq(i)) - 1;
    cod = dec2bin(k, n);
    train = strcat(train, cod);
    Output = char(num2cell(cod));
    Output = reshape(str2num(Output), 1, []);
    arr = [arr Output];
end

disp("Tren de 1s y 0s: ")
disp(train)



%%% D. Gráfica de la codificación %%%

arr
while 1
    disp("Seleccione el tipo de codificación :");
    disp("0-Continuar");
    disp("1-Unipolar NRZ");
    disp("2-Bipolar NRZ");
    disp("3-Unipolar RZ");
    disp("4-Bipolar RZ");
    disp("5-AMI");
    disp("6-Manchester");
    disp("")
    opcion=input("Ingrese la opción: ");
    y=[];
    
    %Tipos dependiendo de la eleccion
    f_s=100;
    %No Return to Zero
    NRZ=ones(1,f_s);
    %Return Zero
    RZ= [ones(1,f_s/2) zeros(1,f_s/2)];
    %Caso especial para Manchester
    Man=[ones(1,f_s/2)  -ones(1,f_s/2)] ;
    
    switch (opcion)
        case 0
            break
        case 1
            %El nivel de amplitud se mantiene durante todo el intervalo de bit
            %Solo admite salidas positivas
            tipo=NRZ;
            for i=1:length(arr)
                switch arr(i)
                    case 1
                        %En caso de 1 se grafica el pulso en todo el
                        %intervalo
                        y=[y  tipo];
                    case 0
                        %En caso de cero no se grafica pulso
                        y=[y  (0*tipo)];
                end
            end
            titulo="Unipolar NRZ";
        case 2
            %El nivel de amplitud se mantiene durante todo el intervalo de bit
            %Admite salidas positivas y negativas
            tipo=NRZ;
            for i=1:length(arr)
                switch arr(i)
                    case 1
                        %En caso de 1 se grafica el pulso positivo en todo
                        %el intervalo
                        y=[y  tipo];
                    case 0
                        %En caso de 0 se grafica el pulso negativo en todo
                        %el intervalo
                        y=[y  -tipo];
                end
            end
            titulo="Bipolar NRZ";
        case 3
            %El pulso positivo retorna a cero
            %Solo admite salidas positivas
            tipo=RZ;
            for i=1:length(arr)
                switch arr(i)
                    case 1
                        %En caso de 1 se grafica pulso positivo y a la
                        %mitad retorna a cero.
                        y=[y  tipo];
                    case 0
                        %En caso de 0 no se grafica pulso
                        y=[y  (0*tipo)];
                end
            end
            titulo="Unipolar RZ";
        case 4
            %Pulsos con retorno a zero en la mitad del bit
            %Admite salidas positivas y negativas
            tipo=RZ;
            for i=1:length(arr)
                switch arr(i)
                    case 1
                        %En caso de 1 se grafica pulso positivo y a la
                        %mitad retorna a cero.
                        y=[y  tipo];
                    case 0
                        %En caso de 0 se grafica pulso negativo y a la
                        %mitad retorna a cero.
                        y=[y  -tipo];
                end
            end
            titulo="Bipolar RZ";
        case 5
            %Pulsos de 1 se alternan entre positivo y negativo,pulso 0 ausencia de pulso
            tipo=RZ;
            count = 0;
            for i=1:length(arr)
                switch arr(i)
                    case 1
                        % En caso de 1 alternamos entre par e impar con mod
                        % para graficar alternadamente.
                        if mod (count,2) == 0
                            y=[y  tipo];
                        else
                            y=[y  -tipo];
                        end
                        count = count + 1;
                    case 0
                        %En caso de 0 no se grafica pulso
                        y=[y  (0*tipo)];
                end
            end
            titulo="AMI RZ";
        case 6
            %pulso positivo: inicia positivo termina negativo
            %pulso negativo: inicia negativo termina positivo
            tipo=Man;
            for i=1:length(arr)
                switch arr(i)
                    case 1
                        y=[y  tipo];
                    case 0
                        y=[y  -tipo];
                end
            end
            titulo="Manchester";
    end
    
    t1=(0:(length(y)-1))/f_s;
    figure;
    plot(t1,y,'LineWidth',3);
    axis([0 160 -3 3]); title('Señal codificada');xlabel('nT_s'); ylabel('x(nT_s)');title(titulo);
    xlim([0 50])
    grid on;
end


%%% E. Demodularización %%%

% Se crea arreglo m_d para almacenar los valores de la demodularización
m_d = [];

% Se calcula el valor de omega.
w = 2 * pi * f_m;

for index = 1 : size(t_n, 2);
    m_d(index) = 0;
    for n = -1000 : 1 : 1000;
        m_d(index) = m_d(index) + (m(T_s * n) * sinc(w * (t_n(index) - n*T_s)));
    end   
end

% Se  grafica la demodularización
subplot(4, 1, 4);
plot(t_n, m_d, 'k');
xlabel('t'); ylabel('m(t)'); title("Gráfica de la señal m_d(t) demodulalizada.");
axis([0 f_m -(max_mt + 0.5) (max_mt + 0.5)]);
