/// @description Lógica das Cutscenes e Efeitos

// --- PROCESSAMENTO DO EFEITO DE CLARÃO BRANCO (FADE OUT) ---
if (flash_alpha > 0) {
    flash_alpha -= flash_speed;
}


// ==============================================================================
// --- 1. LÓGICA DA CUTSCENE 3 (REGRAS -> REVELAR FALLED -> MONÓLOGO) ---
// ==============================================================================
if (cutscene3_ativa) {
    
    switch (cutscene3_passo) {
        case 0:
            exibir_legenda = true;
            locutor_texto = "As gravuras antigas começam a ressoar uma sabedoria ancestral...";
            
            if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("F"))) {
                cutscene3_passo = 1;
            }
        break;

        case 1:
            locutor_texto = "Regra 1: Domine o tempo dos seus ataques para purificar o mal.";
            
            if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("F"))) {
                flash_alpha = 1.0; 
                cutscene3_passo = 2;
            }
        break;

        case 2:
            if (instance_exists(obj_falled)) {
                obj_falled.visible = true;
            }
            
            locutor_texto = "Falled: 'Achas mesmo que essas regras se aplicam a alguém como tu?'";
            
            if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("F"))) {
                cutscene3_passo = 3;
            }
        break;

        case 3:
            locutor_texto = "Falled: 'A luz que persegues é apenas a sombra da tua própria ignorância.'";
            
            if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("F"))) {
                cutscene3_passo = 4;
            }
        break;

        case 4:
            locutor_texto = "Falled: 'Prepara-te. O destino não perdoa hesitações.'";
            
            if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("F"))) {
                cutscene3_passo = 5;
            }
        break;

        case 5:
            exibir_legenda = false;
            locutor_texto   = "";
            cutscene3_ativa = false;
            
            if (instance_exists(obj_player)) {
                obj_player.estado = ESTADO_PLAYER.IDLE;
                var _spr_idle = asset_get_index("spr_player_idle");
                if (_spr_idle != -1) obj_player.sprite_index = _spr_idle;
            }
        break;
    }
    
    exit;
}


// ==============================================================================
// --- 2. LÓGICA DA CUTSCENE 2 (ANJO NA TORRE) ---
// ==============================================================================
if (cutscene_ativa) {
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
    
    exit;
}


// ==============================================================================
// --- 3. LÓGICA DA CUTSCENE 1 (CAMINHADA INICIAL AUTOMÁTICA) ---
// ==============================================================================
if (!instance_exists(player_ref)) exit;

switch (cena_passo) {
    
    // Passo 0: Configuração e Início da Caminhada
    case 0:
        player_ref.estado = ESTADO_PLAYER.CUTSCENE;
        
        pos_inicial_x = player_ref.x;
        var _dir_inicio = player_ref.image_xscale;
        ponto_alvo_x = pos_inicial_x + (_dir_inicio * distancia_caminhar);
        
        // Define a sprite de corrida enquanto se move
        var _spr_run = asset_get_index("spr_player_run");
        if (_spr_run != -1) player_ref.sprite_index = _spr_run;
        
        player_ref.image_index = 0;
        player_ref.image_speed = 1;
        
        cena_passo = 1;
    break;

    // Passo 1: Processamento do Movimento e Parada na Sprite 'Looking'
    case 1:
        var _distancia_restante = abs(player_ref.x - ponto_alvo_x);
        
        // Se ainda está a mover-se em direção ao ponto alvo
        if (_distancia_restante > 4) {
            var _dir_mov = sign(ponto_alvo_x - player_ref.x);
            
            player_ref.vel_h = _dir_mov * (player_ref.vel_max_h * 0.5);
            
            var _spr_run = asset_get_index("spr_player_run");
            if (_spr_run != -1) player_ref.sprite_index = _spr_run;
            
            player_ref.image_xscale = _dir_mov;
            player_ref.image_speed = 1;
        } else {
            // CHEGOU AO ALVO: Para o movimento imediatamente
            player_ref.x = ponto_alvo_x;
            player_ref.vel_h = 0;
            
            // Troca a sprite para 'spr_looking' (procura por nomes comuns do projeto)
            var _spr_look = asset_get_index("spr_looking");
            if (_spr_look == -1) _spr_look = asset_get_index("spr_player_looking");
            
            if (_spr_look != -1) {
                player_ref.sprite_index = _spr_look;
            }
            
            player_ref.image_index = 0;
            player_ref.image_speed = 0.5;
            
            cena_passo = 2; // Avança para o diálogo
        }
    break;

    // Passo 2: Diálogo enquanto permanece na sprite 'Looking'
    case 2:
        // Garante que a sprite continua a ser a 'Looking' durante a exibição do texto
        var _spr_look = asset_get_index("spr_looking");
        if (_spr_look == -1) _spr_look = asset_get_index("spr_player_looking");
        if (_spr_look != -1 && player_ref.sprite_index != _spr_look) {
            player_ref.sprite_index = _spr_look;
        }

        timer++;
        if (timer >= 20) {
            exibir_legenda = true;
            locutor_texto = "Seus olhos contemplam o divino(?)... O destino, antes distante, agora reluz diante dele.";
            
            if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
                exibir_legenda = false;
                timer = 0;
                cena_passo = 3;
            }
        }
    break;

    // Passo 3: Finalização da Cutscene 1
    case 3:
        if (instance_exists(player_ref)) {
            player_ref.estado = ESTADO_PLAYER.IDLE;
            
            var _spr_idle = asset_get_index("spr_player_idle");
            if (_spr_idle == -1) _spr_idle = asset_get_index("spr_idle");
            if (_spr_idle != -1) player_ref.sprite_index = _spr_idle;
        }
        cena_passo = 4;
    break;

    case 4:
    break;
}