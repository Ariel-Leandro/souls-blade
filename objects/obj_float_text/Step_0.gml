/// @description Step Event
y += vel_v;
tempo_vida--;
if (tempo_vida <= 0) {
    alpha -= 0.05;
    if (alpha <= 0) {
        instance_destroy();
    }
}