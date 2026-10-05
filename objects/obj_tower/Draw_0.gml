draw_self();

// Debug: Draw range circle when holding CTRL
if (keyboard_check(vk_control)) {
    draw_set_color(c_red);
    draw_circle(x, y, attack_range, true);
    draw_set_color(c_white);
}