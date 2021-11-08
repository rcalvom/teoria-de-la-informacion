ts = 0.01;
t = [-pi: ts : pi];
a = 1;

x = rectpuls(t, 2*a);

X = fft(x) * ts;


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
        plot(t, X_w, 'b'); xlabel('\omega'); ylabel('X(\omega)'); title('Gráfica de la señal'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada filtrada Y(w).
    subplot(2, 2, 3);
        Y_w = X_w .* LPF;
        plot(t, Y_w, 'b'); xlabel('\omega'); ylabel('Y(\omega)'); title('Gráfica de la señal filtrada'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada y(t) tras el filtro.
    subplot(2, 2, 4);
        y = abs(ifft(ifftshift(Y_w))/ts);
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
        x_p = abs(ifft(ifftshift(Y_w))/ts);
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
        x_p = abs(ifft(ifftshift(Y_w))/ts);
        plot(t, x_p, 'b'); xlabel('t'); ylabel('y(t)'); title('Gráfica del pulso tras el filtrado'); grid; axis([-pi pi -1/4 5/4]);


% Ventana del Filtro suprime-bandas ideal.
figure('Name', 'Filtro suprime-bandas ideal');

    % Subgráfica del filtro suprime-bandas ideal.
    subplot(2, 2, 1);
        % Calculo del filtro.
        w1 = 0.25;
        w2 = 0.75;
        BFS = (t < -w2) | ((t > -w1) & (t < w1)) | (t > w2);
        plot(t, BPF, 'b'); xlabel('t'); ylabel('h(t)'); title('Gráfica del filtro suprime-bandas ideal'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada X(w).
    subplot(2, 2, 2);
        plot(t, X_w, 'b'); xlabel('\omega'); ylabel('X(\omega)'); title('Gráfica de la transformada'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada filtrada Y(w).
    subplot(2, 2, 3);
        Y_w = X_w .* BFS;
        plot(t, Y_w, 'b'); xlabel('\omega'); ylabel('Y(\omega)'); title('Gráfica de la señal filtrada'); grid; axis([-pi pi -1/4 5/4]);

    % Subgráfica de la transformada y(t) tras el filtro.
    subplot(2, 2, 4);
        x_p = abs(ifft(ifftshift(Y_w))/ts);
        plot(t, x_p, 'b'); xlabel('t'); ylabel('y(t)'); title('Gráfica del pulso tras el filtrado'); grid; axis([-pi pi -1/4 5/4]);

