/// @description Revela a plataforma se o player atingi-la em estado de DIVE
if (!visible && instance_exists(obj_player)) {
    if (obj_player.estado == ESTADO_PLAYER.DIVE && place_meeting(x, y - obj_player.vel_v, obj_player)) {
        visible = true;
    }
}