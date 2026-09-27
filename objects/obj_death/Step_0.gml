/// @description Transição de Fade e Entrada de Reinício

if (alpha_tela < 1) {
    alpha_tela += vel_fade;
}

if (pode_reiniciar && (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter))) {
    room_goto(Room1); // Nome da room principal de gameplay
}