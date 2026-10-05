/// @description Evento Step do obj_cutscene_manager

// --- 1. PROCESSAMENTO DA CUTSCENE 2 (ANJO / TORRE) ---
if (variable_instance_exists(id, "cutscene_ativa") && cutscene_ativa) {
    timer_cutscene++;

    if (timer_cutscene >= tempo_duracao || keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        cutscene_ativa = false;
        
        if (instance_exists(obj_angel2)) {
            instance_destroy(obj_angel2);
        }

        if (instance_exists(obj_player)) {
            obj_player.estado = ESTADO_PLAYER.IDLE;
        }
    }
    
    exit; // Não executa a cutscene 1 se a cutscene 2 estiver rodando
}


// --- 2. PROCESSAMENTO DA CUTSCENE 1 (INICIAL) ---
if (!instance_exists(player_ref)) exit;

switch (cena_passo) {
    
    case 0:
        player_ref.estado = ESTADO_PLAYER.CUTSCENE;
        
        var _distancia = abs(player_ref.x - ponto_alvo_x);
        
        // Se ainda está a mais de 4 pixels do ponto de parada: CORRE COM METADE DA VELOCIDADE
        if (_distancia > 4) {
            var _dir = sign(ponto_alvo_x - player_ref.x);
            
            player_ref.vel_h = _dir * (player_ref.vel_max_h * 0.5);
            player_ref.olhando_para_direita = (_dir > 0);
            player_ref.sprite_index = player_ref.spr_run;
            player_ref.image_speed = 1;
        } else {
            // Chegou no alvo: Para e troca para a sprite de olhando
            player_ref.x = ponto_alvo_x;
            player_ref.vel_h = 0;
            
            player_ref.sprite_index = player_ref.spr_looking;
            player_ref.image_index = 0;
            player_ref.image_speed = 0.5;
            
            cena_passo = 1;
        }
    break;

    case 1:
        timer++;
        if (timer >= 20) {
            exibir_legenda = true;
            locutor_texto = "Seus olhos contemplam o divino(?)... O destino, antes distante, agora reluz diante dele.";
            
            if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
                exibir_legenda = false;
                timer = 0;
                cena_passo = 2;
            }
        }
    break;

    case 2:
        // Devolve o controle ao jogador
        player_ref.estado = ESTADO_PLAYER.IDLE;
        player_ref.sprite_index = player_ref.spr_idle;
        cena_passo = 3;
    break;

    case 3:
        // Cutscene inicial concluída
    break;
}