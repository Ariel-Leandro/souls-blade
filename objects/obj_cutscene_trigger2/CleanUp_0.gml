/// @description Devolve o controle ao player ao encerrar
if (instance_exists(obj_player)) {
    obj_player.estado = ESTADO_PLAYER.IDLE;
}