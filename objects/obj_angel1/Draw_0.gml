/// @description Renderização com inversão de cor
if (!visible) exit;

if (color_invert) {
    gpu_set_fog(true, c_fuchsia, 0, 0);
    draw_self();
    gpu_set_fog(false, c_fuchsia, 0, 0);
} else {
    draw_self();
}