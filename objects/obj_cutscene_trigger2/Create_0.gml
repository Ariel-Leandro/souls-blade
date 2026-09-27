/// @description Evento Create do obj_cutscene_trigger2

// Configura o jogador para o estado de cutscene e altera o visual
if (instance_exists(obj_player)) {
    obj_player.estado = ESTADO_PLAYER.CUTSCENE;
    obj_player.vel_h = 0;
    obj_player.vel_v = 0;
    
    // Força a sprite de "olhando"
    obj_player.sprite_index = obj_player.spr_looking;
    obj_player.image_index = 0;
    obj_player.image_speed = 1;
    
    // Cancela o processamento de dano/ataque ativo
    if (ds_exists(obj_player.inimigos_atingidos, ds_type_list)) {
        ds_list_clear(obj_player.inimigos_atingidos);
    }
}

// Cria o obj_angel2 se ele ainda não existir na sala
if (!instance_exists(obj_angel2)) {
    var _spawn_x = x;
    var _spawn_y = y - 40;
    
    if (instance_exists(obj_player)) {
        _spawn_x = obj_player.x + 80;
        _spawn_y = obj_player.y - 60;
    }
    
    instance_create_depth(_spawn_x, _spawn_y, -100, obj_angel2);
}

// Variáveis de diálogo e controle de tempo
texto_fala = " PaRE, ****** enganado s**** ";
timer_cutscene = 0;
tempo_duracao = 240; // Duração em frames (~4 segundos a 60fps)