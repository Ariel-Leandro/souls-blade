// Alarm 0: Player olha para o anjo
with (obj_angel1) visible = false;
with (obj_player) {
    if (instance_exists(obj_angel1)) olhando_para_direita = (obj_angel1.x > x);
    sprite_index = spr_idle;
}
alarm[1] = 120;