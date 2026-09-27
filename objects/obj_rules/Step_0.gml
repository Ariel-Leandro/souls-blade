/// @description Evento Step do obj_rules

if (instance_exists(obj_player)) {
    var _dist = point_distance(x, y, obj_player.x, obj_player.y);
    
    // Verifica se o jogador está no raio, vivo e fora de cutscene
    if (_dist <= distancia_interacao && obj_player.stats.esta_vivo && obj_player.estado != ESTADO_PLAYER.CUTSCENE) {
        player_perto = true;
        
        if (keyboard_check_pressed(ord("F"))) {
            if (instance_exists(obj_cutscene_manager)) {
                obj_cutscene_manager.iniciar_cutscene3();
            }
        }
    } else {
        player_perto = false;
    }
} else {
    player_perto = false;
}