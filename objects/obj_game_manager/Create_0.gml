/// @description Evento Create do obj_cutscene_manager

// --- VARIÁVEIS DA CUTSCENE INICIAL (CUTSCENE 1) ---
cena_passo = 0;
timer = 0;
player_ref = instance_find(obj_player, 0);

// Distância para o player andar
distancia_caminhar = 100; 

// Ponto final X calculado a partir da posição inicial do player
pos_inicial_x = 0;
ponto_alvo_x = 0;

if (player_ref != noone) {
    player_ref.estado = ESTADO_PLAYER.CUTSCENE;
    
    // Salva o X inicial do player e define onde ele deve parar
    pos_inicial_x = player_ref.x;
    
    var _dir_inicio = player_ref.olhando_para_direita ? 1 : -1;
    ponto_alvo_x = pos_inicial_x + (_dir_inicio * distancia_caminhar);
    
    // FORÇA O JOGADOR A INICIAR CORRENDO COM METADE DA VELOCIDADE
    player_ref.vel_h = _dir_inicio * (player_ref.vel_max_h * 0.5);
    player_ref.sprite_index = player_ref.spr_run;
    player_ref.image_index = 0;
    player_ref.image_speed = 1;
}

// Variáveis de Legenda
exibir_legenda = false;
locutor_texto = "";


// --- VARIÁVEIS E GATILHO DA CUTSCENE 2 (ANJO / TORRE) ---
timer_cutscene = 0;
tempo_duracao = 240; // 4 segundos a 60fps
cutscene_ativa = false;

/// @description Método/Gatilho de execução da Cutscene 2
iniciar_cutscene2 = function() {
    if (instance_exists(obj_player)) {
        obj_player.estado = ESTADO_PLAYER.CUTSCENE;
        obj_player.vel_h = 0;
        obj_player.vel_v = 0;
        
        if (variable_instance_exists(obj_player, "spr_looking")) {
            obj_player.sprite_index = obj_player.spr_looking;
        }
        obj_player.image_index = 0;
        obj_player.image_speed = 1;
        
        if (variable_instance_exists(obj_player, "inimigos_atingidos")) {
            if (ds_exists(obj_player.inimigos_atingidos, ds_type_list)) {
                ds_list_clear(obj_player.inimigos_atingidos);
            }
        }
    }

    if (!instance_exists(obj_angel2)) {
        var _spawn_x = x;
        var _spawn_y = y;
        
        if (instance_exists(obj_player)) {
            _spawn_x = obj_player.x + 80;
            _spawn_y = obj_player.y - 60;
        }
        
        instance_create_depth(_spawn_x, _spawn_y, -100, obj_angel2);
    }

    self.timer_cutscene = 0;
    self.tempo_duracao = 240;
    self.cutscene_ativa = true;
};

iniciar_cutscene2 = method(id, iniciar_cutscene2);