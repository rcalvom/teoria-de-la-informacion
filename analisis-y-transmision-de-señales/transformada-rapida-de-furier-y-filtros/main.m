function main()

% Valores iniciales
disp('Ingrese a');
a = input('a =');
F = 100;
Fs=1/F;
t=[-pi:Fs:pi]; % Vector de tiempo
f = t/Fs; % Vector de frecuencia
fr=@(t) (t>-a)&(t<a);

% Pulso rectangular en el dominio especifico
x=fr(t);
subplot(2,1,1);
plot (t, x, 'r'); grid; axis([-2.5 2.5 -0.1 1.1])
title(strcat('Pulso rectangular entre -', num2str(a),' y ',num2str(a)));
xlabel('Tiempo(t)');
ylabel('x(t)')

% Pulso rectangular con FFT

