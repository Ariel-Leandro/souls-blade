/// @description Colisão com obj_player

if (cutscene_rodando) exit;

cutscene_rodando = true;
player_ref = other;
player_ref.estado = ESTADO_PLAYER.CUTSCENE;
player_ref.vel_h = 0;

// Busca prioritariamente por obj_angel1
if (instance_exists(obj_angel1)) {
    anjo_ref = instance_find(obj_angel1, 0);
} else if (instance_exists(obj_enemy)) {
    anjo_ref = instance_find(obj_enemy, 0);
}

if (anjo_ref != noone) {
    anjo_ref.visible = true;
    player_ref.olhando_para_direita = (anjo_ref.x > player_ref.x);
}