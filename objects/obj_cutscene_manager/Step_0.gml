/// @description Lógica das Cutscenes e Efeitos

// ==============================================================================
// --- PROCESSAMENTO DO EFEITO DE CLARÃO BRANCO
// ==============================================================================

if (flash_alpha > 0) {
    flash_alpha -= flash_speed;
    if (flash_alpha < 0) {
        flash_alpha = 0;
    }
}


// ==============================================================================
// --- MENSAGEM SOBRE SOPHIA
// ==============================================================================

if (mensagem_sophia_ativa) {
    
    exibir_legenda = true;
    
    locutor_texto =
        "Ele não pode guiá-lo pois também desconhece a Sophia, "
        + "sua jornada até aqui foi o começo, não o fim... "
        + "a não ser que desistas de experimentar o doce sabor do pleroma.";
    
    // --------------------------------------------------------------------------
    // FECHAR MENSAGEM
    // --------------------------------------------------------------------------
    
    if (
        keyboard_check_pressed(vk_space)
        || keyboard_check_pressed(vk_enter)
        || keyboard_check_pressed(ord("F"))
    ) {
        
        mensagem_sophia_ativa = false;
        exibir_legenda = false;
        locutor_texto = "";
        
        // ----------------------------------------------------------------------
        // LIBERA O TRIGGER DA CUTSCENE 3 DIRETAMENTE AO FECHAR A MENSAGEM
        // ----------------------------------------------------------------------
        
        if (instance_exists(obj_cutscene_trigger3)) {
            with (obj_cutscene_trigger3) {
                ativado = true; // Libera o funcionamento na colisão
            }
        }
    }
    
    // Enquanto essa mensagem estiver aberta,
    // nenhuma outra cutscene pode executar.
    
    exit;
}


// ==============================================================================
// --- 1. LÓGICA DA CUTSCENE 1
// --- CAMINHADA INICIAL AUTOMÁTICA
// ==============================================================================

if (!instance_exists(player_ref)) {
    exit;
}

switch (cena_passo) {
    
    // Passo 0 — Início da Caminhada
    case 0:
        player_ref.estado = ESTADO_PLAYER.CUTSCENE;
        pos_inicial_x = player_ref.x;
        
        var _dir_inicio = player_ref.image_xscale;
        ponto_alvo_x = pos_inicial_x + (_dir_inicio * distancia_caminhar);
        
        var _spr_run = asset_get_index("spr_player_run");
        if (_spr_run != -1) {
            player_ref.sprite_index = _spr_run;
        }
        
        player_ref.image_index = 0;
        player_ref.image_speed = 1;
        cena_passo = 1;
    break;
    
    // Passo 1 — Movimento
    case 1:
        var _distancia_restante = abs(player_ref.x - ponto_alvo_x);
        
        if (_distancia_restante > 4) {
            var _dir_mov = sign(ponto_alvo_x - player_ref.x);
            
            player_ref.vel_h = _dir_mov * (player_ref.vel_max_h * 0.5);
            
            var _spr_run = asset_get_index("spr_player_run");
            if (_spr_run != -1) {
                player_ref.sprite_index = _spr_run;
            }
            
            player_ref.image_xscale = _dir_mov;
            player_ref.image_speed = 1;
        } 
        else {
            player_ref.x = ponto_alvo_x;
            player_ref.vel_h = 0;
            
            var _spr_look = asset_get_index("spr_looking");
            if (_spr_look == -1) {
                _spr_look = asset_get_index("spr_player_looking");
            }
            
            if (_spr_look != -1) {
                player_ref.sprite_index = _spr_look;
            }
            
            player_ref.image_index = 0;
            player_ref.image_speed = 0.5;
            cena_passo = 2;
        }
    break;
    
    // Passo 2 — Diálogo
    case 2:
        var _spr_look = asset_get_index("spr_looking");
        if (_spr_look == -1) {
            _spr_look = asset_get_index("spr_player_looking");
        }
        
        if (_spr_look != -1 && player_ref.sprite_index != _spr_look) {
            player_ref.sprite_index = _spr_look;
        }
        
        timer++;
        
        if (timer >= 20) {
            exibir_legenda = true;
            locutor_texto =
                "Seus olhos contemplam o divino(?)... "
                + "O destino, antes distante, agora reluz diante dele.";
            
            if (
                keyboard_check_pressed(vk_space)
                || keyboard_check_pressed(vk_enter)
            ) {
                exibir_legenda = false;
                locutor_texto = "";
                
                timer = 0;
                cena_passo = 3;
            }
        }
    break;
    
    // Passo 3 — Finalização
    case 3:
        if (instance_exists(player_ref)) {
            player_ref.estado = ESTADO_PLAYER.IDLE;
            
            var _spr_idle = asset_get_index("spr_player_idle");
            if (_spr_idle == -1) {
                _spr_idle = asset_get_index("spr_idle");
            }
            
            if (_spr_idle != -1) {
                player_ref.sprite_index = _spr_idle;
            }
        }
        
        cena_passo = 4;
    break;
    
    // Passo 4 — Finalizado
    case 4:
    break;
}


// ==============================================================================
// --- 2. LÓGICA DA CUTSCENE 2
// --- ANJO NA TORRE
// ==============================================================================

if (cutscene_ativa) {
    
    timer_cutscene++;
    
    if (
        timer_cutscene >= tempo_duracao
        || keyboard_check_pressed(vk_space)
        || keyboard_check_pressed(vk_enter)
    ) {
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
// --- 3. LÓGICA DA CUTSCENE 3
// --- CLARÃO AUTOMÁTICO -> ARRIVE -> CAMINHADA -> MONÓLOGO
// ==============================================================================

if (cutscene3_ativa) {
    
    switch (cutscene3_passo) {
        
        // Passo 0: Clarão rápido e automático (avança sozinho sem apertar nada)
        case 0:
            exibir_legenda = false;
            locutor_texto = "";
            
            // Dispara o clarão forte imediatamente
            flash_alpha = 1.0;
            
            // Avança imediatamente para o passo 1 no próximo frame
            cutscene3_passo = 1;
        break;
        
        // Passo 1: O obj_falled aparece com spr_arrive e o texto inicial começa
        case 1:
            exibir_legenda = true;
            locutor_texto = "As gravuras antigas começam a ressoar uma sabedoria ancestral...";
            
            if (instance_exists(obj_falled)) {
                obj_falled.visible = true;
                
                var _spr_arrive = asset_get_index("spr_arrive");
                if (_spr_arrive != -1) {
                    obj_falled.sprite_index = _spr_arrive;
                }
                obj_falled.image_index = 0;
                obj_falled.image_speed = 1;
            }
            
            if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("F"))) {
                cutscene3_passo = 2;
            }
        break;
        
        // Passo 2: O Falled começa a caminhar (spr_falled_walk)
        case 2:
            locutor_texto = "Regra 1: Domine o tempo dos seus ataques para purificar o mal.";
            
            if (instance_exists(obj_falled)) {
                var _spr_walk = asset_get_index("spr_falled_walk");
                if (_spr_walk != -1) {
                    obj_falled.sprite_index = _spr_walk;
                }
                obj_falled.image_speed = 1;
            }
            
            if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("F"))) {
                cutscene3_passo = 3;
            }
        break;
        
        // Passo 3: Início do monólogo com spr_monologe ("Falso Parabéns")
        case 3:
            if (instance_exists(obj_falled)) {
                var _spr_mono = asset_get_index("spr_monologe");
                if (_spr_mono != -1) {
                    obj_falled.sprite_index = _spr_mono;
                }
                obj_falled.image_speed = 1;
            }
            
            locutor_texto = "Falled: 'Achas mesmo que essas regras se aplicam a alguém como tu?'";
            
            if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("F"))) {
                cutscene3_passo = 4;
            }
        break;
        
        // Passo 4: Continuação do monólogo
        case 4:
            locutor_texto = "Falled: 'A luz que persegues é apenas a sombra da tua própria ignorância.'";
            
            if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("F"))) {
                cutscene3_passo = 5;
            }
        break;
        
        // Passo 5: Retorna para spr_falled padrão antes de encerrar
        case 5:
            if (instance_exists(obj_falled)) {
                var _spr_falled_default = asset_get_index("spr_falled");
                if (_spr_falled_default != -1) {
                    obj_falled.sprite_index = _spr_falled_default;
                }
            }
            
            locutor_texto = "Falled: 'Prepara-te. O destino não perdoa hesitações.'";
            
            if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("F"))) {
                cutscene3_passo = 6;
            }
        break;
        
        // Passo 6 (Finalização)
        case 6:
            exibir_legenda = false;
            locutor_texto = "";
            cutscene3_ativa = false;
            
            if (instance_exists(obj_player)) {
                obj_player.estado = ESTADO_PLAYER.IDLE;
                
                var _spr_idle = asset_get_index("spr_player_idle");
                if (_spr_idle != -1) {
                    obj_player.sprite_index = _spr_idle;
                }
            }
        break;
    }
    
    exit;
}