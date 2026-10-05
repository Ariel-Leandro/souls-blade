/// @description Interrompe o DIVE caso a plataforma esteja visível
if (image_alpha > 0.2 && other.estado == ESTADO_PLAYER.DIVE) {
    if (other.y < y) {
        other.vel_v = 0;
        other.estado = ESTADO_PLAYER.IDLE;
    }
}