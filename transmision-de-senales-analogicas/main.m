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