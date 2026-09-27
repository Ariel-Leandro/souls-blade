/// @description Evento Create do obj_angel1

// Guarda o ponto inicial para ele flutuar ao redor do próprio eixo
x_start_angel = x;
y_start_angel = y;

// Temporizador interno
tempo_flutuar = 0;

// Configurações da flutuação (ajuste para mais/menos movimento)
velocidade_flutuar = 0.05; // Velocidade do balanço
amplitude_y        = 6;    // Quantos pixels sobe e desce
amplitude_x        = 3;    // Quantos pixels vai para os lados

/// @description Configurações iniciais do anjo
visible = false;
flicker_timer = 0;
color_invert = false;