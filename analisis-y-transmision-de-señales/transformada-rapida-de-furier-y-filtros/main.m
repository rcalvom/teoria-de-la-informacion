% Valores iniciales
disp('Ingrese a');
a = input('a = ');
F = 100;
Fs = 1/F;
t = [-pi : Fs : pi]; % Vector de tiempo
f = t/Fs; % Vector de frecuencia
fr = @(t) (t>-a)&(t<a);

% Pulso rectangular en el dominio especifico
x = fr(t);
subplot(2,1,1);
plot (t, x, 'r'); grid; axis([-2.5 2.5 -0.1 1.1])
title(strcat('Pulso rectangular entre -', num2str(a),' y ',num2str(a)));
xlabel('Tiempo(t)');
ylabel('x(t)')

% Pulso rectangular con FFT
ff = fft(x)*Fs;
X = fftshift(abs(ff));
subplot(2,1,2);
stem(f, X, '.r'); %la graficamos en barras para poder comparar
xlabel('\omega');
ylabel('X(\omega)'); grid;  title('Comparacion función FFT() y analiticamente');
hold on
% Tambien la graficamos analiticamente para compararla
sa=@(x) ((sin(x)+(x==0))./(x+(x==0))); %Genera la función sa(x) = sin (x)/x
omega=[-20:0.1:20];
plot(omega, abs(2*a*sa(a*omega)), '-b'); hold off; axis([-20 20 -0.1 2.5]); legend('FFT Matlab', 'FFT analitica');

X = fft(x) * Fs;
X_w = fftshift(X);

% Ventana del Filtro pasa-bajas ideal.
figure('Name', 'Filtro pasa-bajas ideal');

    % Subgráfica del filtro pasa-bajas ideal.
    subplot(2, 2, 1);
        % Calculo del filtro.
        wc = 0.5;
        LPF = (t < wc) & (t > -wc);
        plot(t, LPF, 'b'); xlabel('t'); ylabel('h(t)'); title('Gráfica del filtro pasa-bajas ideal'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada X(w).
    subplot(2, 2, 2);
        plot(t, X_w, 'b'); xlabel('\omega'); ylabel('X(\omega)'); title('Gráfica de la transformada'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada filtrada Y(w).
    subplot(2, 2, 3);
        Y_w = X_w .* LPF;
        plot(t, Y_w, 'b'); xlabel('\omega'); ylabel('Y(\omega)'); title('Gráfica de la señal filtrada'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada y(t) tras el filtro.
    subplot(2, 2, 4);
        y = abs(ifft(ifftshift(Y_w))/Fs);
        plot(t, y, 'b'); xlabel('t'); ylabel('y(t)'); title('Gráfica del pulso tras el filtrado'); grid; axis([-pi pi -1/4 5/4]);


% Ventana del Filtro pasa-altas ideal.
figure('Name', 'Filtro pasa-altas ideal');

    % Subgráfica del filtro pasa-altas ideal.
    subplot(2, 2, 1);
        % Calculo del filtro.
        wc = 0.5;
        HPF = (t > wc) | (t < -wc);
        plot(t, HPF, 'b'); xlabel('t'); ylabel('h(t)'); title('Gráfica del filtro pasa-altas ideal'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada X(w).
    subplot(2, 2, 2);
        plot(t, X_w, 'b'); xlabel('\omega'); ylabel('X(\omega)'); title('Gráfica de la transformada'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada filtrada Y(w).
    subplot(2, 2, 3);
        Y_w = X_w .* HPF;
        plot(t, Y_w, 'b'); xlabel('\omega'); ylabel('Y(\omega)'); title('Gráfica de la señal filtrada'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada y(t) tras el filtro.
    subplot(2, 2, 4);
        x_p = abs(ifft(ifftshift(Y_w))/Fs);
        plot(t, x_p, 'b'); xlabel('t'); ylabel('y(t)'); title('Gráfica del pulso tras el filtrado'); grid; axis([-pi pi -1/4 5/4]);


% Ventana del Filtro pasa-bandas ideal.
figure('Name', 'Filtro pasa-bandas ideal');

    % Subgráfica del filtro pasa-bandas ideal.
    subplot(2, 2, 1);
        % Calculo del filtro.
        w1 = 0.25;
        w2 = 0.75;
        BPF = ((t < w2) & (t > w1)) | ((t > -w2) & (t < -w1));
        plot(t, BPF, 'b'); xlabel('t'); ylabel('h(t)'); title('Gráfica del filtro pasa-bandas ideal'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada X(w).
    subplot(2, 2, 2);
        plot(t, X_w, 'b'); xlabel('\omega'); ylabel('X(\omega)'); title('Gráfica de la transformada'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada filtrada Y(w).
    subplot(2, 2, 3);
        Y_w = X_w .* BPF;
        plot(t, Y_w, 'b'); xlabel('\omega'); ylabel('Y(\omega)'); title('Gráfica de la señal filtrada'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada y(t) tras el filtro.
    subplot(2, 2, 4);
        x_p = abs(ifft(ifftshift(Y_w))/Fs);
        plot(t, x_p, 'b'); xlabel('t'); ylabel('y(t)'); title('Gráfica del pulso tras el filtrado'); grid; axis([-pi pi -1/4 5/4]);


% Ventana del Filtro suprime-bandas ideal.
figure('Name', 'Filtro suprime-bandas ideal');

    % Subgráfica del filtro suprime-bandas ideal.
    subplot(2, 2, 1);
        % Calculo del filtro.
        w1 = 0.25;
        w2 = 0.75;
        BFS = (t < -w2) | ((t > -w1) & (t < w1)) | (t > w2);
        plot(t, BFS, 'b'); xlabel('t'); ylabel('h(t)'); title('Gráfica del filtro suprime-bandas ideal'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada X(w).
    subplot(2, 2, 2);
        plot(t, X_w, 'b'); xlabel('\omega'); ylabel('X(\omega)'); title('Gráfica de la transformada'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada filtrada Y(w).
    subplot(2, 2, 3);
        Y_w = X_w .* BFS;
        plot(t, Y_w, 'b'); xlabel('\omega'); ylabel('Y(\omega)'); title('Gráfica de la señal filtrada'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada y(t) tras el filtro.
    subplot(2, 2, 4);
        x_p = abs(ifft(ifftshift(Y_w))/Fs);
        plot(t, x_p, 'b'); xlabel('t'); ylabel('y(t)'); title('Gráfica del pulso tras el filtrado'); grid; axis([-pi pi -1/4 5/4]);