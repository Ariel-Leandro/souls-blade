/// @description Evento Step do obj_box

// Verifica se está colidindo com o objeto do jogador enquanto ele ataca
var _inst_player = instance_place(x, y, obj_player);

if (_inst_player != noone) {
    // Verifica se a sprite atual do jogador é a de ataque
    if (_inst_player.sprite_index == spr_player_atack) {
        
        // Cria o item dropado na mesma posição da caixa
        instance_create_layer(x, y, layer, obj_drop_1);
        
        // Destrói a caixa
        instance_destroy();
    }
}