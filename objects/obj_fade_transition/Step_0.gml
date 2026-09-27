/// @description Processa a opacidade do Fade Out

alpha += fade_speed;

if (alpha >= 1) {
    alpha = 1;
    if (room_exists(sala_destino)) {
        room_goto(sala_destino);
    }
}