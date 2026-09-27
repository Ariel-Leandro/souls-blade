/// @description Detecta proximidade de 5 pixels para o Parry perfeito

if (instance_exists(obj_player) && !parry_ativado) {
    var _distancia = point_distance(x, y, obj_player.x, obj_player.y);
    
    // Se o projétil estiver a 5 pixels ou menos do player
    if (_distancia <= 35) {
        
        // Se o player estiver no estado de defesa/parry nesse exato momento de quase-impacto
        if (obj_player.estado == ESTADO_PLAYER.PARRY) {
            scr_spawn_float_text(obj_player.x, obj_player.y - 28, "PARRY!!!", c_aqua);
            parry_ativado = true;
            instance_destroy(); // Defende, rebate/destrói o projétil com sucesso absoluto!
        }
    }
}