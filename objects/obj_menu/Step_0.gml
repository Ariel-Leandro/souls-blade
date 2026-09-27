var _cima  = keyboard_check_pressed(vk_up)   || keyboard_check_pressed(ord("W"));
var _baixo = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
var _selecionar = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);

if (_cima) {
    opcao_selecionada--;
    if (opcao_selecionada < 0) opcao_selecionada = total_opcoes - 1;
}

if (_baixo) {
    opcao_selecionada++;
    if (opcao_selecionada >= total_opcoes) opcao_selecionada = 0;
}

if (_selecionar) {
    switch (opcao_selecionada) {
        case 0: 
            // Vai para a Room do seu jogo (Room1)
            room_goto(Room1); 
            break;
            
        case 1: 
            game_end();
            break;
    }
}

tempo_flutuacao += 0.05;