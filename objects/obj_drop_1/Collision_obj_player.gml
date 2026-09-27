/// @description Coleta o item e ativa a invencibilidade por 10 segundos
if (pode_coletar) {
    other.invincible = true;
    other.invincible_timer = 600;
    other.invincible_timer_max = 600;
    instance_destroy();
}