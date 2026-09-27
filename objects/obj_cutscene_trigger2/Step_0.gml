/// @description Controle de tempo da Cutscene

timer_cutscene++;

// Encerra a cutscene após o tempo limite ou ao pressionar Espaço/Enter
if (timer_cutscene >= tempo_duracao || keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
    if (instance_exists(obj_angel2)) {
        instance_destroy(obj_angel2);
    }
    instance_destroy();
}          