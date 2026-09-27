/// @description Draw Event
draw_set_alpha(alpha);
draw_set_color(cor);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(x, y, string(texto));

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);