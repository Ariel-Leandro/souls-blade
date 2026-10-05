/// @description Colisão do projétil com o player defendendo ou em parry

if (instance_exists(other)) {
    if (other.estado == ESTADO_PLAYER.PARRY) {
        if (other.parry_perfeito_ativo) {
            // y - 50 garante que o texto estoure visível na tela
            scr_spawn_float_text(other.x, other.y - 50, "PARRY!!!", c_aqua);
            show_debug_message("SUCESSO NO PARRY!");
        } else {
            show_debug_message("Defesa comum (passou do tempo)");
        }
        instance_destroy();
    } 
    else {
        // Define o dano base
        var _dano_final = 10;
        
        // Se o player estiver com o shader/invencibilidade ativa, reduz o dano pela metade
        if (other.invincible) {
            _dano_final = _dano_final * 0.5; // 10 vira 5
        }
        
        // Aplica o dano calculado
        other.stats.aplicar_dano(_dano_final);
        
        instance_destroy();
    }
}